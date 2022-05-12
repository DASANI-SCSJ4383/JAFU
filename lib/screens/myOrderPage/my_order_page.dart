import 'package:flutter/material.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

class MyOrderPage extends StatelessWidget {

  final UserViewmodel _userviewmodel;
  const MyOrderPage(UserViewmodel userviewmodel)
      : _userviewmodel = userviewmodel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 201, 197, 197),
              margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
              // margin: EdgeInsets.all(15),
              // decoration: BoxDecoration(
              //   color: Color.fromARGB(255, 201, 197, 197),
              //   borderRadius: BorderRadius.all(Radius.circular(20))
              // ),
            ),
          ),
        ],
      ),
    );
  }
}