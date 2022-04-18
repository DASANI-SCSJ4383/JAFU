
abstract class RegService {

  Future<String> registerUser(String username, String password, String phoneNum);
  Future<String> checkPhoneNumber(String phoneNum, String type);

}
