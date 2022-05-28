import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:jafu/services/facerecognition/database.dart';
import 'package:jafu/viewmodel/group_viewmodel.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

import '../../services/facerecognition/facenet.service.dart';
import '../../services/facerecognition/ml_kit_service.dart';
import '../facerecognition/signin.dart';

class GroupTabBar2 extends StatefulWidget {

  final UserViewmodel _userViewmodel;
  final GroupViewmodel _groupViewmodel;
  final int _index;
  const GroupTabBar2(UserViewmodel viewmodel,GroupViewmodel groupviewmodel,int index) : _userViewmodel = viewmodel,_groupViewmodel = groupviewmodel,_index = index;

  @override
  State<GroupTabBar2> createState() => _GroupTabBar2State();
}

class _GroupTabBar2State extends State<GroupTabBar2> {

  bool isReadmore = false;
  int activeIndex = 0;
  CameraDescription cameraDescription;
  bool loading = false;
  FaceNetService _faceNetService = FaceNetService();
  MLKitService _mlKitService = MLKitService();
  DataBaseService _dataBaseService = DataBaseService();

  Future<void> getMyPost() async {
    await widget._groupViewmodel.getMyPost(widget._groupViewmodel.group[widget._index].groupID,widget._userViewmodel.user.userID);
  }

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  _startUp() async {
    _setLoading(true);

    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

    // start the services
    await _faceNetService.loadModel();
    await _dataBaseService.loadDB(widget._userViewmodel);
    _mlKitService.initialize();

    _setLoading(false);
  }

  _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          children: [
            Text(
              "Seller Management",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                height:300,
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.30,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, "/managePost",arguments: [widget._userViewmodel,widget._groupViewmodel,widget._index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white,width: 2)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.edit),
                            SizedBox(height: 10,),
                            Text(
                              "Manage Post",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SignIn(
                              widget._userViewmodel,
                              widget._groupViewmodel,
                              widget._index,
                              cameraDescription:cameraDescription,
                            ),
                          ),
                        );
                        
                        // Navigator.pushNamed(context, "/addPost",arguments: [widget._userViewmodel,widget._groupViewmodel,widget._index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white,width: 2)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add),
                            SizedBox(height: 10,),
                            Text(
                              "Add Post",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white,width: 2)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.interests),
                          SizedBox(height: 10,),
                          Text(
                            "Manage Order",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white,width: 2)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.history),
                          SizedBox(height: 10,),
                          Text(
                            "Order History",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget buildText(String text){
    
    final lines = isReadmore ? null : 3;
    
    return Text(
      text,
      maxLines: lines,
    );
  }
}