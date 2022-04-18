import 'package:jafu/app/dependencies.dart';
import 'package:jafu/services/register/reg_service.dart';
import 'package:jafu/viewmodel/viewmodel.dart';

class RegisterViewModel extends Viewmodel {

  RegService get regService => dependency();
  
  Future<String> register(String username,String password, String phoneNum) async {
    String a = await regService.registerUser(username,password,phoneNum);
    return a;
  }

  Future<String> checkPhoneNumber(String phoneNum) async {
    String a = await regService.checkPhoneNumber(phoneNum, "noTel");
    return a;
  }

}