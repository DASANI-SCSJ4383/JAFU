import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class PhoneSignInProvider extends ChangeNotifier{

  var _verificationCode;
  
  Future verifyPhone(String phoneNum) async{
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNum, 
      verificationCompleted: (PhoneAuthCredential credential) async{
        await FirebaseAuth.instance.signInWithCredential(credential);
        // notifyListeners();
      }, 
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        // notifyListeners();
      }, 
      codeSent: (String verificationID, int resendToken) async {
            _verificationCode = verificationID;
      }, 
      codeAutoRetrievalTimeout: (String verificationID){
            _verificationCode = verificationID;
      },
      timeout: Duration(seconds: 60)
    );
  }

  Future sendCodeToFirebase({String code}) async {
    await FirebaseAuth.instance.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: _verificationCode, smsCode: code
      )
    ).then((value) async{
      notifyListeners();
    });
       
  }
 
}