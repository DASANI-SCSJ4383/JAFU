import 'package:flutter/material.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

class GroupPage extends StatelessWidget {

  final UserViewmodel _userviewmodel;
  const GroupPage(UserViewmodel userviewmodel)
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
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (BuildContext, index){
                  return ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.black),
                    title: Text("This is title"),
                    subtitle: Text("This is subtitle"),
                  );
                },
                separatorBuilder: (BuildContext,index){
                  return Divider(height: 1);
                }, 
                shrinkWrap: true,
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
              )
            ),
          ),
        ],
      ),
    );
  }
}
// ListView.builder(
//                 itemCount: 55,
//                 itemBuilder: (BuildContext context,int index){
//                   return ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.black,
//                     ),
//                     trailing: Text("GFG",
//                                   style: TextStyle(
//                                     color: Colors.green,fontSize: 15),),
//                     title:Text("List item $index")
//                   );
//                 }
//               ),