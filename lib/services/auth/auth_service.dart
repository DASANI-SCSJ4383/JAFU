
import '../../model/user.dart';

abstract class AuthService {

  Future<User> authenticate(String noTel, String password);
}
