
class User{
  String _userID; // Use dynamic type because json-server userID is int and firestore userID is string
  String _username;
  String _email;
  String _password;
  String _address;
  String _userType;
  String _phoneNum;

  get userID => _userID;
  set userID(value) => _userID = value;

  get username => _username;
  set username(value) => _username = value;

  get email => _email;
  set email(value) => _email = value;

  get password => _password;
  set password(value) => _password = value;

  get address => _address;
  set address(value) => _address = value;

  get userType => _userType;
  set userType(value) => _userType = value;

  get phoneNum => _phoneNum;
  set phoneNum(value) => _phoneNum = value;

  User(
      {
        dynamic userID,
        String username = '',
        String email = '',
        String password = '',
        String address = '',
        String userType = '',
        String phoneNum = '',
      }
  ) : _userID = userID,
      _username = username,
      _email = email,
      _password = password,
      _address = address,
      _userType = userType,
      _phoneNum = phoneNum;

  User.copy(User from)
      : this(
            userID: from.userID,
            username: from.username,
            email: from.email,
            password: from.password,
            address: from.address,
            userType: from.userType,
            phoneNum: from.phoneNum,);

  User.fromJson(Map<String, dynamic> json)
      : this(
          userID: json['userID'],
          username: json['username'],
          email: json['email'],
          password: json['password'],
          address: json['address'],
          userType: json['userType'],
          phoneNum: json['phoneNum'],
        );

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'username': username,
        'email': userType,
        'password': password,
        'address': address,
        'userType': userType,
        'phoneNum': phoneNum,
      };
}
