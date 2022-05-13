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
        return SafeArea(
          child: Scaffold(
          // extendBody: true,
          backgroundColor: Color(0xff191720),
          appBar: AppBar(
            backgroundColor: Color(0xff191720),
            // leading: IconButton(
            //   icon: Icon(Icons.menu),
            //   iconSize: 30.0,
            //   color: Colors.white,
            //   onPressed: () {},
            // ),
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
                icon: Icon(Icons.add),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () async {
                 final result = await Navigator.pushNamed(context, "/createGroup", arguments: widget._userviewmodel);
                 if(result != null){
                   print("refresh");
                 }else{
                   print("not refresh");
                 }
                },
              ),
              IconButton(
                icon: Icon(Icons.chat),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () {
                  myState(() {
                    page = 2;
                  });
                },
              ),
            ],
          ),
          body: screens[page],
          drawer: Drawer(
            backgroundColor: Color(0xff191720),
            child: Column(children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:const [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1594616838951-c155f8d978a0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Lee Wang",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Software Engenieer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //Now let's Add the button for the Menu
            //and let's copy that and modify it
            ListTile(
              onTap: () {
                myState(() {
                  page = 0;
                });
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text("Homepage",style: TextStyle(color: Colors.white)),
            ),
        
            ListTile(
              onTap: () {
                myState(() {
                  page = 1;
                });
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.inbox,
                color: Colors.white,
              ),
              title: Text("My Order",style: TextStyle(color: Colors.white)),
            ),
        
            // ListTile(
            //   onTap: () {
            //     myState(() {
            //       page = 2;
            //     });
            //     Navigator.pop(context);
            //   },
            //   leading: Icon(
            //     Icons.chat,
            //     color: Colors.white,
            //   ),
            //   title: Text("Chat",style: TextStyle(color: Colors.white)),
            // ),
        
            ListTile(
              onTap: () {
                myState(() {
                  page = 3;
                });
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text("My Profile",style: TextStyle(color: Colors.white)),
            ),
        
            ListTile(
              onTap: () {
                myState(() {
                  page = 3;
                });
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text("Logout",style: TextStyle(color: Colors.white)),
            ),
          ])
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   backgroundColor: Color(0xff191720),
          //   currentIndex: page,
          //   items:const [
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.home),
          //       label: "Home",
          //       backgroundColor: Colors.black
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.shop),
          //       label: "MyOrder",
          //       backgroundColor: Colors.black
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.chat),
          //       label: "Chat",
          //       backgroundColor: Colors.black
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.account_circle),
          //       label: "Me",
          //       backgroundColor: Colors.black
          //     )
          //   ],
          //   onTap: (index){
          //     myState(() {
          //       page = index;
          //     });
          //   },
          // )
              ),
        );
      }
    );
  }
}