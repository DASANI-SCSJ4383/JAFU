
import 'package:jafu/app/dependencies.dart';
import 'package:jafu/models/user.dart';
import 'package:jafu/services/auth/auth_service.dart';
import 'package:jafu/viewmodel/viewmodel.dart';

class LoginViewmodel extends Viewmodel {

  AuthService get _service => dependency();

  Future<User> authenticate(String noTel, String password) async {
    final User _user = await _service.authenticate(noTel,password);
    return _user;
  }

  Future<String> updateUserToken(String token) async {
    
  }

}