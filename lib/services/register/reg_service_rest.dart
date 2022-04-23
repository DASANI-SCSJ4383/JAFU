import 'package:flutter/foundation.dart';
import 'package:jafu/services/register/reg_service.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

class RegServiceRest implements RegService {

  final String _baseUrl;
  const RegServiceRest({@required baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<String> registerUser(String username, String password, String phoneNum) async {
    var url = _baseUrl + "/register";
    final r = RetryOptions(maxAttempts: 6);
    try{
      var result = await r.retry(() => http.post(Uri.parse(url), body: {
        "username": username,
        "password": password,
        "phoneNum": phoneNum,
      }));
      String response = result.body;
      if (result == null || response == "false") return null;
      return response;
    }catch(e){
      return "Network Problem";
    }
    
  }

  @override
  Future<String> checkPhoneNumber(String phoneNum, String type) async {
    var url = _baseUrl + "/checkInputAvailability/'" + phoneNum + "'/" + type;
    var result = await http.get(Uri.parse(url));
    String response = result.body;
    if (result == null || response == "invalid") return null;
    return response;
  }

}
