import 'dart:convert';

import 'package:assingment_2/services/register/reg_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

class RegServiceRest implements RegService {
  final String _baseUrl;
  const RegServiceRest({@required baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<String> registerUser(
      String username, String password, String phoneNum) async {
    print(password);
    print(phoneNum);
    print(username);
    var url = _baseUrl + "register";
    final r = RetryOptions(maxAttempts: 6);
    try {
      var result = await r.retry(() => http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "username": username,
            "password": password,
            "phoneNum": phoneNum,
          })));
      String response = result.body;
      print(response);
      if (response == "false") return "false";
      return response;
    } catch (e) {
      return "Network Problem";
    }
  }
}
