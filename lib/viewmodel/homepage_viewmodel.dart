import 'dart:convert';

import 'package:jafu/app/dependencies.dart';
import 'package:jafu/services/auth/auth_service.dart';
import 'package:jafu/viewmodel/viewmodel.dart';

class HomePageViewModel extends Viewmodel {

  AuthService get _service => dependency();

  List testList = ["34","ghf","jk78"];
  
  Future<void> testing() async {
    String myJson = jsonEncode(testList);
  }

  Future<void> test() async {
    String myJson = jsonEncode(testList);
    List re = jsonDecode(myJson);
    await _service.testing(myJson);
  }

}