import 'package:flutter/foundation.dart';
import 'package:retry/retry.dart';
import '../../model/user.dart';
import 'auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthServiceRest implements AuthService {
  final String _baseUrl;
  AuthServiceRest({@required baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<User> authenticate(String noTel, String password) async {
    var encodedNoTel = Uri.encodeComponent(noTel);
    var encodedPass = Uri.encodeComponent(password);
    // var url = _baseUrl + "login/$encodedNoTel/$encodedPass";
    var url = "http://10.211.102.249:8080/login/+60192330215/123456";
    // var url = _baseUrl + "login/${urlEncode(text: noTel)}/${urlEncode(text: password)}";
    final r = RetryOptions(maxAttempts: 6);
    try {
      var result = await r.retry(() => http.get(Uri.parse(url)));
      String response = result.body;
      print(response);
      if (response == "false") {
        User a = User();
        return a;
      } else {
        final json = jsonDecode(result.body);
        final _user = User.fromJson(json);
        return _user;
      }
    } catch (e) {
      print(e);
      User a = User();
      return a;
    }
  }
}
