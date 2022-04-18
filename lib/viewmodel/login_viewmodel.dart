
import 'package:jafu/app/dependencies.dart';
import 'package:jafu/models/user.dart';
import 'package:jafu/services/auth/auth_service.dart';
import 'package:jafu/viewmodel/viewmodel.dart';

class LoginViewmodel extends Viewmodel {

  AuthService get _service => dependency();

  Future<User> authenticate(String email, String password) async {
    final User _user = await _service.authenticate(email: email, password: password);
    if (_user == null) {
      print("Not Found");
    }
    return _user;
  }

}