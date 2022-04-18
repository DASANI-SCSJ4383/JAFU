import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jafu/viewmodel/homepage_viewmodel.dart';
import 'package:jafu/viewmodel/view.dart';

class Homepage extends StatefulWidget {

  static Route route() =>
      MaterialPageRoute(builder: (context) => Homepage());

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Logged In"),
        actions: [
          TextButton(
            child: Text("Logout",style: TextStyle(color: Colors.black)),
            onPressed: (){
              // final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              // provider.googleLogout();
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: View(
        viewmodel: HomePageViewModel(),
        builder: (context, viewmodel, _) => Container(
          alignment: Alignment.center,
          color: Colors.blueGrey.shade900,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Profile",style: TextStyle(fontSize: 24)),
              // SizedBox(height: 8),
              // CircleAvatar(
              //   radius: 40,
              //   backgroundImage: NetworkImage(user.photoURL),
              // ),
              SizedBox(height: 8),
              Text(user.uid,style: TextStyle(fontSize: 24)),
              ElevatedButton(onPressed: (){
                viewmodel.test();
              }, child: Text("Try")),
              SizedBox(height: 8),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/facerecognition');
              }, child: Text("Register Face"))
            ],
          ),
        ),
      ),
    );
  }
}