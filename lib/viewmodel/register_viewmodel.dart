
import '../app/dependencies.dart';
import '../services/register/reg_service.dart';

class RegisterViewModel{

  RegService get regService => dependency();
  
  Future<String> register(String username,String password, String phoneNum) async {
    String a = await regService.registerUser(username,password,phoneNum);
    return a;
  }

}