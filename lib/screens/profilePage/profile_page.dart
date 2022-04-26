import 'package:flutter/material.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

class ProfilePage extends StatelessWidget {

  final UserViewmodel _userviewmodel;
  const ProfilePage(UserViewmodel userviewmodel)
      : _userviewmodel = userviewmodel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 201, 197, 197),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            ),
          ),
        ],
      ),
    );
  }
}