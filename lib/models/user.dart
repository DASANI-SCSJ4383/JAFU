
class User{
  dynamic _id; // Use dynamic type because json-server id is int and firestore id is string
  String _name;
  String _email;
  String _password;
  String _address;
  String _photoUrl;
  String _phoneNum;

  // ignore: unnecessary_getters_setters
  get id => _id;
  // ignore: unnecessary_getters_setters
  set id(value) => _id = value;

  get name => _name;
  set name(value) => _name = value;

  get email => _email;
  set email(value) => _email = value;

  get password => _password;
  set password(value) => _password = value;

  get address => _address;
  set address(value) => _address = value;

  get photoUrl => _photoUrl;
  set photoUrl(value) => _photoUrl = value;

  get phoneNum => _phoneNum;
  set phoneNum(value) => _phoneNum = value;

  User(
      {
        dynamic id,
        String name = '',
        String email = '',
        String password = '',
        String address = '',
        String photoUrl = '',
        String phoneNum = '',
      }
  ) : _id = id,
      _name = name,
      _email = email,
      _password = password,
      _address = address,
      _photoUrl = photoUrl,
      _phoneNum = phoneNum;

  User.copy(User from)
      : this(
            id: from.id,
            name: from.name,
            email: from.email,
            password: from.password,
            address: from.address,
            photoUrl: from.photoUrl,
            phoneNum: from.phoneNum,);

  User.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          password: json['password'],
          address: json['address'],
          photoUrl: json['photoUrl'],
          phoneNum: json['phoneNum'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': photoUrl,
        'password': password,
        'address': address,
        'photoUrl': photoUrl,
        'phoneNum': phoneNum,
      };
}
