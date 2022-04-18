import 'package:flutter/material.dart';

class UserFace {
  String user;
  String password;

  UserFace({@required this.user, @required this.password});

  static UserFace fromDB(String dbuser) {
    return new UserFace(user: dbuser.split(':')[0], password: dbuser.split(':')[1]);
  }
}
