import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jafu/screens/facerecognition/signin.dart';
import 'package:jafu/screens/facerecognition/signup.dart';
import 'package:jafu/services/facerecognition/database.dart';
import 'package:jafu/services/facerecognition/facenet.service.dart';
import 'package:jafu/services/facerecognition/ml_kit_service.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

class Menu extends StatefulWidget {
  static Route route({userviewmodel}) =>
      MaterialPageRoute(builder: (context) => Menu(userviewmodel: userviewmodel));

  final UserViewmodel _userviewmodel;

  Menu({userviewmodel}) : _userviewmodel = userviewmodel;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // Services injection
  FaceNetService _faceNetService = FaceNetService();
  MLKitService _mlKitService = MLKitService();
  DataBaseService _dataBaseService = DataBaseService();

  CameraDescription cameraDescription;
  bool loading = false;

  String githubURL =
      "https://github.com/MCarlomagno/FaceRecognitionAuth/tree/master";

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  /// 1 Obtain a list of the available cameras on the device.
  /// 2 loads the face net model
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
    await _dataBaseService.loadDB(widget._userviewmodel);
    _mlKitService.initialize();

    _setLoading(false);
  }

  // shows or hides the circular progress indicator
  _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  // void _launchURL() async => await canLaunch(githubURL)
  //     ? await launch(githubURL)
  //     : throw 'Could not launch $githubURL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFC7FFBE),
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: PopupMenuButton<String>(
              child: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (value) {
                switch (value) {
                  case 'Clear DB':
                    _dataBaseService.cleanDB();
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Clear DB'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
      body: !loading
          ? SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image(image: AssetImage('assets/images/facelogo.png')),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: const [
                          Text(
                            "FACE RECOGNITION AUTHENTICATION",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Demo application that uses Flutter and tensorflow to implement authentication with facial recognition",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignIn(
                                  widget._userviewmodel,
                                  cameraDescription: cameraDescription,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  blurRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(color: Color(0xFF0F0BDB)),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.login, color: Color(0xFF0F0BDB))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            print(widget._userviewmodel.user.userID);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignUp(cameraDescription,widget._userviewmodel),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF0F0BDB),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  blurRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'SIGN UP',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.person_add, color: Colors.white)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        // InkWell(
                        //   onTap: _launchURL,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       color: Colors.black,
                        //       boxShadow: <BoxShadow>[
                        //         BoxShadow(
                        //           color: Colors.blue.withOpacity(0.1),
                        //           blurRadius: 1,
                        //           offset: Offset(0, 2),
                        //         ),
                        //       ],
                        //     ),
                        //     alignment: Alignment.center,
                        //     padding: EdgeInsets.symmetric(
                        //         vertical: 14, horizontal: 16),
                        //     width: MediaQuery.of(context).size.width * 0.8,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Text(
                        //           'CONTRIBUTE',
                        //           style: TextStyle(color: Colors.white),
                        //         ),
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         FaIcon(
                        //           FontAwesomeIcons.github,
                        //           color: Colors.white,
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}