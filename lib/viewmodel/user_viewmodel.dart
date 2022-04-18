import 'package:jafu/app/dependencies.dart';
import 'package:jafu/models/user.dart';
import 'package:jafu/services/auth/auth_service.dart';

class UserViewmodel{
  AuthService get _service => dependency();
  User _user;

  get user => _user;
  set user(value) => _user = value;

  bool get isUserSignedIn => _user != null;

  void authenticate(User user) async => _user =
      await _service.authenticate(email: user.email, password: user.password);

}