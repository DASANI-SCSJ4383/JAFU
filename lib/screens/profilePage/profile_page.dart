import 'package:flutter/material.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {

  final UserViewmodel _userviewmodel;
  const ProfilePage(UserViewmodel userviewmodel)
      : _userviewmodel = userviewmodel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // CategorySelector(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/facerecognition',arguments: _userviewmodel);
                    }, 
                    child: Text("Test Face Reognition")
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: ()async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('user');
                      Navigator.popAndPushNamed(context, '/login');
                    }, 
                    child: Text("Logout")
                  )
                ],
              )
              
            ),
          ),
        ],
      ),
    );
  }
}