import '../../models/user.dart';

abstract class AuthService {

  Future<User> authenticate(String noTel, String password);
  Future<String> testing(String a);
}
