import '../app/dependencies.dart';
import '../model/user.dart';
import '../services/auth/auth_service.dart';

class LoginViewmodel{

  AuthService get _service => dependency();

  Future<User> authenticate(String noTel, String password) async {
    final User _user = await _service.authenticate(noTel,password);
    return _user;
  }

}