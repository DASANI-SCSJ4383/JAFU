import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:retry/retry.dart';
import '../../models/user.dart' as user;
import 'auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_encoder/url_encoder.dart'; 

class AuthServiceRest implements AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  final String _baseUrl;
  AuthServiceRest({@required baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<user.User> authenticate(String username, String password) async {
    var url = _baseUrl + "/login/${urlEncode(text: username)}/${urlEncode(text: password)}";
    final r = RetryOptions(maxAttempts: 6);
    try{
      var result = await r.retry(() => http.get(Uri.parse(url)));
      String response = result.body;
      if (response == "false"){
        user.User a = user.User();
        a = null;
        return a;
      }else{
        final json = jsonDecode(result.body);
        final _user = user.User.fromJson(json);
        return _user;
      } 
    }catch(e){
      user.User a = user.User();
      a = null;
      return a;
    }  
  }

  Future<String> signIn({String email, String password}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  Future<String> testing(String a) async{
    print("sini");
    var url = "http://10.211.100.10/jafu/try.php";
    var result = await http.post(Uri.parse(url), body:{
      "userID" : "4",
      "faceData" : a
    });
    print(result.body);
    print("kkkkkkk");
  }

}
