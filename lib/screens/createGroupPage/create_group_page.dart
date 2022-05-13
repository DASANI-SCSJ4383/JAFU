import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:jafu/screens/widgets/constants.dart';
import 'package:jafu/viewmodel/group_viewmodel.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CreateGroupPage extends StatefulWidget {

  static Route route({userviewmodel}) =>
      MaterialPageRoute(builder: (context) => CreateGroupPage(userviewmodel: userviewmodel));

  final UserViewmodel _userviewmodel;

  CreateGroupPage({userviewmodel}) : _userviewmodel = userviewmodel;

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {

  final groupName = TextEditingController();
  final groupDescription = TextEditingController();
  GroupViewmodel _viewmodel = GroupViewmodel();
  bool isObsecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              groupName.clear();
              groupDescription.clear();
              Navigator.pop(context);
            },
            icon: Image(
              width: 24,
              color: Colors.white,
              image: Svg('assets/images/back_arrow.svg'),
            ),
          )
        ),
        body: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: (){
    
            },
            child: ListView(
              children: [
                SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      Container(
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
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Colors.white
                            ),
                            color: Colors.blue
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ), 
                SizedBox(height: 100),
                TextFormField(
                  controller: groupName,
                  style: kBodyText.copyWith(color: Colors.white,fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Group Name",
                    hintStyle: kBodyText,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: groupDescription,
                  style: kBodyText.copyWith(color: Colors.white,fontSize: 20),
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Group Description",
                    hintStyle: kBodyText,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                SizedBox(height: 30),  
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: (){
                        groupName.clear();
                        groupDescription.clear();
                        Navigator.pop(context);
                      }, 
                      child: Text("CANCEL",style: TextStyle(fontSize: 15,letterSpacing: 2,color: Colors.black)),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                    ),
                    OutlinedButton(
                      onPressed: ()async{
                                    FocusScopeNode currentFocus = FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    if(groupName.text.isEmpty || groupDescription.text.isEmpty){
                                      final SnackBar snackBar = SnackBar(content: Text("Please fill in all the field to proceed."),
                                                                  duration: Duration(seconds: 1, milliseconds: 500),
                                                                );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                    else{
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.loading
                                      );
                                      String result = await _viewmodel.createGroup(groupName.text,groupDescription.text,widget._userviewmodel.user.userID);
                                      if(result == "success"){
                                        Navigator.pop(context);
                                        Alert(
                                          onWillPopActive: true,
                                          closeFunction: (){
                                            groupName.clear();
                                            groupDescription.clear();
                                            Navigator.pop(context);
                                          },
                                          context: context,
                                          type: AlertType.success,
                                          title: "SUCCESS",
                                          desc: "Your registration was successful.",
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "OK",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              onPressed: (){
                                                groupName.clear();
                                                groupDescription.clear();
                                                Navigator.pop(context);
                                                Navigator.pop(context,"update");
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
                                                groupName.clear();
                                                groupDescription.clear();
                                                Navigator.pop(context);
                                              },
                                              width: 120,
                                            )
                                          ],
                                        ).show();
                                      }
                                    }
                                  },
                      child: Text("SAVE",style: TextStyle(fontSize: 15,letterSpacing: 2,color: Colors.black)),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}