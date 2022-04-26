import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jafu/screens/chatPage/chat_page.dart';
import 'package:jafu/screens/groupPage/group_page.dart';
import 'package:jafu/screens/myOrderPage/my_order_page.dart';
import 'package:jafu/screens/profilePage/profile_page.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

class Homepage extends StatefulWidget {

  // static Route route({userviewmodel}) => MaterialPageRoute(
  //     builder: (context) => Homepage(userviewmodel: userviewmodel));

  // final UserViewmodel _userviewmodel;

  // const Homepage({userviewmodel}) : _userviewmodel = userviewmodel;

  final UserViewmodel _userviewmodel;
  const Homepage(UserViewmodel userviewmodel)
      : _userviewmodel = userviewmodel;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {

    int page = 0;

    final screens = [
      GroupPage(widget._userviewmodel),
      MyOrderPage(widget._userviewmodel),
      ChatPage(widget._userviewmodel),
      ProfilePage(widget._userviewmodel),
    ];

    return StatefulBuilder
    (
      builder: (thisLowerContext, myState) {
        return Scaffold(
        // extendBody: true,
        backgroundColor: Color(0xff191720),
        appBar: AppBar(
          backgroundColor: Color(0xff191720),
          leading: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
          title: Text(
            'JAFU',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
        body: screens[page],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff191720),
          currentIndex: page,
          items:const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
              label: "MyOrder",
              backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "Chat",
              backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "Me",
              backgroundColor: Colors.black
            )
          ],
          onTap: (index){
            myState(() {
              page = index;
            });
          },
        )
      );
      }
    );
  }
}