import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

class GroupPage extends StatefulWidget {

  final UserViewmodel _userviewmodel;
  const GroupPage(UserViewmodel userviewmodel)
      : _userviewmodel = userviewmodel;

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  Widget bodyWidget;
  int page;
  DateTime prebackpress = DateTime.now();

  @override
  void initState() {
    super.initState();
    bodyWidget = bodyFirst();
    page = 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: ()async{
          if(page == 1){
            final timegap = DateTime.now().difference(prebackpress);
    
            final cantExit = timegap >= Duration(seconds: 2);
    
            prebackpress = DateTime.now();
    
            if (cantExit) {
              final snack = SnackBar(
                content: Text('Press Back button again to Exit'),
                duration: Duration(seconds: 2),
              );
    
              ScaffoldMessenger.of(context).showSnackBar(snack);
    
              return false;
            } else {
              SystemNavigator.pop();
              return true;
            }
          }else{
            setState(() {
              page = 1;
              bodyWidget = bodyFirst();
            });
            return false;
          }
        },
        child: Scaffold(
          body: bodyWidget,
        ),
      ),
    );
  }

  Widget avatarWidget(String urlImg, double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            image: NetworkImage(urlImg),
          )),
    );
  }

  List<String> _avatarUrl = [
    "https://images.unsplash.com/photo-1573890990305-0ab6a7195ab6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
    "https://images.unsplash.com/photo-1545130368-4c55e2418062?ixlib=rb-1.2.1&auto=format&fit=crop&w=926&q=80",
    "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
    "https://images.unsplash.com/photo-1470441623172-c47235e287ee?ixlib=rb-1.2.1&auto=format&fit=crop&w=1052&q=80",
    "https://images.unsplash.com/photo-1458662236860-b721a6735660?ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
    "https://images.unsplash.com/photo-1530268729831-4b0b9e170218?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
    "https://images.unsplash.com/photo-1534308143481-c55f00be8bd7?ixlib=rb-1.2.1&auto=format&fit=crop&w=1188&q=80",
    "https://images.unsplash.com/photo-1525879000488-bff3b1c387cf?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1535201344891-231e85e83c8a?ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
  ];

  Widget storyButton(String urlImg, double radius) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                image: NetworkImage(urlImg),
              )),
        ),
      ),
    );
  }

  Widget listItem(
      String urlImg, String userName, String, message, String hour) {
    return InkWell(
      onTap: () {
        setState(() {
          page = 2;
          bodyWidget = secondBody();
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Container(
          child: Row(
            children: [
              avatarWidget(urlImg, 60.0),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                hour,
                style: TextStyle(
                  color: Colors.grey[50],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyFirst() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 35.0),
          child: Column(
            children: [
              //First let's create our menu bar
              // Row(
              //   children: [
              //     // for the first par i'll need to create a custom widget for my avatar button
              //     avatarWidget(_avatarUrl[0], 50.0),
              //     SizedBox(
              //       width: 10.0,
              //     ),
              //     Expanded(
              //       child: Text(
              //         "Messages",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 20.0,
              //           fontWeight: FontWeight.w700,
              //         ),
              //       ),
              //     ),
              //     MaterialButton(
              //       onPressed: () {},
              //       elevation: 0.0,
              //       padding: EdgeInsets.all(8.0),
              //       color: Colors.blue,
              //       shape: CircleBorder(),
              //       child: Icon(Icons.edit, color: Colors.white),
              //     )
              //   ],
              // ),
              //Now let's create the search bar
              // SizedBox(
              //   height: 20.0,
              // ),
              TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    hintText: "Search",
                    contentPadding: EdgeInsets.only(left: 34.0),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Now it's time to create our list view for storys
              // Container(
              //   height: 60.0,
              //   width: double.infinity,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       //let's now create our story widget, but before let's add the add button
              //       MaterialButton(
              //         onPressed: () {},
              //         elevation: 0.0,
              //         padding: EdgeInsets.all(8.0),
              //         color: Colors.grey[800],
              //         shape: CircleBorder(),
              //         child: Icon(Icons.add, color: Colors.grey[300]),
              //       ),
              //       //Now let's create our storybutton widget
              //       storyButton(_avatarUrl[1], 60.0),
              //       storyButton(_avatarUrl[2], 60.0),
              //       storyButton(_avatarUrl[3], 60.0),
              //       storyButton(_avatarUrl[4], 60.0),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 10.0,
              ),
              //Now we will build the chat feed listview
              Expanded(
                child: ListView.builder(
                  itemCount: 17,
                  itemBuilder: (context, index) => listItem(_avatarUrl[2], "David ro", String, "Wassup", "9:53PM"),
                ) 
                // ListView(
                //   children: [
                //     //first let's create our list items widget
                //     listItem(
                //         _avatarUrl[2], "David ro", String, "Wassup", "9:53PM"),
                //     listItem(_avatarUrl[3], "kasidie", String,
                //         "We are waiting for you", "8:33PM"),
                //     listItem(_avatarUrl[4], "Lynda", String,
                //         "Hey can you help me", "6:54AM"),
                //     listItem(_avatarUrl[5], "Suizie Q", String, "hank you",
                //         "Yesterday"),
                //     listItem(_avatarUrl[7], "Joseph", String, "Hey wassup",
                //         "Yesterday"),
                //     listItem(_avatarUrl[8], "Jonathan", String, "okey",
                //         "Mon, 8:50AM"),
                //     //and now all what you have to do is to duplicate that line to have a real chat feed
                //   ],
                // ),
              )
            ],
          ),
        ),
      );
  }

  // Widget bodyFirst() {
  //   return Column(
  //       children: <Widget>[
  //         // CategorySelector(),
  //         Expanded(
  //           child: Container(
  //             margin: const EdgeInsets.only(top: 15.0),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(30.0),
  //                 topRight: Radius.circular(30.0),
  //               )
  //             ),
  //             child: ListView.builder(
  //               itemCount: 15,
  //               itemBuilder: (context,index){
  //                 return buildListTile();
  //               } 
  //             )
  //           ),
  //         ),
  //       ],
  //     );
  // }

  Widget buildListTile() => ListTile(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    leading: CircleAvatar(
      radius: 28,
      backgroundColor: Colors.black,
    ),
    title: Text("Test",style: TextStyle(color: Colors.black),),
    onTap: (){
      setState(() {
        page = 2;
        bodyWidget = secondBody();
      });
    },    
  );

  Widget secondBody(){
  return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => Card(
      margin: const EdgeInsets.all(10),
      child: Container(
        height: 350.0,
        child: Column(
          children: <Widget> [
            ListTile(
              leading: CircleAvatar(),
              title: Text("asdasd"),
              subtitle: Text("asdasdas"),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://picsum.photos/250?image=9"),
                    fit: BoxFit.cover
                  )
                ),
              ), 
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: const [
                    Icon(Icons.thumb_up,color: Colors.grey,),
                    SizedBox(width: 8),
                    Text("asd"),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.thumb_up,color: Colors.grey),
                    SizedBox(width: 8),
                    Text("asd"),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.thumb_up,color: Colors.grey),
                    SizedBox(width: 8),
                    Text("asd"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.0,)
          ],
        ),
      ),
    ) 
    );
  }

}