import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jafu/models/post.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

import '../../services/facerecognition/database.dart';
import '../../services/facerecognition/facenet.service.dart';
import '../../services/facerecognition/ml_kit_service.dart';

class ReviewPost extends StatefulWidget {

  static Route route({userviewmodel,post,imageList}) =>
      MaterialPageRoute(builder: (context) => ReviewPost(userviewmodel: userviewmodel,post: post,imageList: imageList));

  final UserViewmodel _userviewmodel;
  final Post _post;
  final List<XFile> _imageList;

  const ReviewPost({userviewmodel,post,imageList}) : _userviewmodel = userviewmodel,_post = post,_imageList = imageList;

  @override
  State<ReviewPost> createState() => _ReviewPostState();
}

class _ReviewPostState extends State<ReviewPost> {

  final FaceNetService _faceNetService = FaceNetService();
  final MLKitService _mlKitService = MLKitService();
  final DataBaseService _dataBaseService = DataBaseService();

  CameraDescription cameraDescription;
  bool loading = false;

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
    await _dataBaseService.loadDB(widget._userviewmodel);
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
    return Container(
      
    );
  }
}