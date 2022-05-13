import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:jafu/screens/widgets/constants.dart';
import 'package:jafu/viewmodel/group_viewmodel.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../homePage/home_page.dart';

class GroupInfoPage extends StatelessWidget {

  static Route route({groupViewmodel,userViewmodel,index}) => MaterialPageRoute(
      builder: (context) =>
          GroupInfoPage(groupViewmodel: groupViewmodel,userViewmodel: userViewmodel,index: index));

  final GroupViewmodel _groupViewmodel;
  final UserViewmodel _userViewmodel;
  final int _index;

  const GroupInfoPage({groupViewmodel,userViewmodel, index})
      : _groupViewmodel = groupViewmodel,
      _userViewmodel = userViewmodel,
      _index = index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.white,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          Center(
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(width: 4,color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1)
                  )
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://cdn.pixabay.com/photo/2017/11/27/21/31/computer-2982270_960_720.jpg"
                  )
                )
              ),
            ),
          ),
          SizedBox(height: 24,),
          Column(
            children: [
              Text(_groupViewmodel.searchGroup[_index].groupName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24)),
              SizedBox(height: 4),
              Text("Test",style: TextStyle(color: Colors.grey)), 
            ],
          ),
          SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () async{
                String result = await _groupViewmodel.joinGroup(_userViewmodel.user.userID,_groupViewmodel.searchGroup[_index].groupID);
                if(result == "success"){
                  Alert(
                    onWillPopActive: true,
                    closeFunction: (){
                      Navigator.pop(context);
                    },
                    context: context,
                    type: AlertType.success,
                    title: "SUCCESS",
                    desc: "Your have join this group.",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  Homepage(_userViewmodel)),
                          );
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                }else{
                  Navigator.pop(context);
                  Alert(
                    onWillPopActive: true,
                    context: context,
                    type: AlertType.error,
                    title: "ERROR",
                    desc: "Something went wrong. Please try again.",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                }
              },
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
              child: Text("JOIN")
            ),
          ),
          SizedBox(height: 24),
          Center(
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    onPressed: (){
            
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("MEMBER",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                        SizedBox(height: 5),
                        Text(_groupViewmodel.searchGroup[_index].totalUser + " peoples",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  VerticalDivider(),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    onPressed: (){
            
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text("RATE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                        SizedBox(height: 5),
                        Text("5.0",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  VerticalDivider(),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    onPressed: (){
            
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text("FRAUD",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                        SizedBox(height: 5),
                        Text("0",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 48),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("About",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24)),
                SizedBox(height: 16),
                Text(_groupViewmodel.searchGroup[_index].groupDescription,style: TextStyle(color: Colors.white,fontSize: 16,height: 1.4)),
              ],
            ),
          )
        ],
      )
    );
  }
}

Widget buildImage(){
  final image = NetworkImage("https://picsum.photos/250?image=9");
  return ClipOval(
    child: Ink.image(
      image: image,
      fit: BoxFit.cover,
      width: 128,
      height: 128,
    ),
  );
}