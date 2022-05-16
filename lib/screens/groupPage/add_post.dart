import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jafu/screens/widgets/constants.dart';
import 'package:jafu/services/facerecognition/database.dart';
import 'package:jafu/services/facerecognition/ml_kit_service.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';
import '../../services/facerecognition/facenet.service.dart';
import '../facerecognition/signin.dart';

class AddPost extends StatefulWidget {
  static Route route({userviewmodel}) =>
      MaterialPageRoute(builder: (context) => AddPost(userviewmodel: userviewmodel));

  final UserViewmodel _userviewmodel;

  const AddPost({userviewmodel}) : _userviewmodel = userviewmodel;

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  final FaceNetService _faceNetService = FaceNetService();
  final MLKitService _mlKitService = MLKitService();
  final DataBaseService _dataBaseService = DataBaseService();

  CameraDescription cameraDescription;
  bool loading = false;

  final ImagePicker _picker = ImagePicker();
  final name = TextEditingController();
  final price = TextEditingController();
  int mode = 0;
  final List<XFile> _imageList = [];

  void selectImage()async{
    final XFile selectedImage = await _picker.pickImage(source: ImageSource.camera);
    if(selectedImage!=null){
      _imageList.add(selectedImage);
    }
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
    return StatefulBuilder(
      builder: (thisLowerContext, myState) {
        return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              if(mode == 1){
                myState(() {
                  mode = 0;
                });
              }
              else{
                Navigator.pop(context);
              }
            },
          ),
          title: Text("Add some details",style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0xff191720),
          actions: [
            mode == 1?
            IconButton(
              icon: Icon(Icons.check_outlined),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {
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
            ):
            Container()
          ],
        ),
        body: SingleChildScrollView(
          child: mode == 0?
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 50,),
                TextFormField(
                  controller: name,
                  style: kBodyText.copyWith(color: Colors.black,fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Title/Item Name*",
                    labelText: "Title/Item Name",
                    hintStyle: kBodyText,
                    fillColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.black,
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
                SizedBox(height: 20,),
                TextFormField(
                  controller: price,
                  style: kBodyText.copyWith(color: Colors.black,fontSize: 20),
                  decoration: InputDecoration(
                    prefixText: "RM ",
                    hintText: "Price*",
                    labelText: "Price",
                    hintStyle: kBodyText,
                    fillColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.black,
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
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),],
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: name,
                  maxLines: 5,
                  style: kBodyText.copyWith(color: Colors.black,fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Details*",
                    labelText: "Details",
                    hintStyle: kBodyText,
                    fillColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.black,
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
                SizedBox(height: 70,),
                ElevatedButton(
                  onPressed: (){
                    myState(() {
                      mode = 1;
                    });
                  },
                  child: Text("Next"),
                )
              ],
            ),
          ):Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("You can add pictures up to 6 only",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10), 
                  itemCount: _imageList.length,
                  itemBuilder: (BuildContext ctx,index){
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(File(_imageList[index].path)),
                      )
                    );
                  }
                ),
                SizedBox(height: 25,),
                ElevatedButton(
                  onPressed: ()async{
                    final XFile selectedImage = await _picker.pickImage(source: ImageSource.camera);
                    if(selectedImage!=null){
                      _imageList.add(selectedImage);
                    }
                    myState(() {
                      
                    });
                  },
                  child: Text("Pick Image"),
                ),
              ],
            ),
          ),
        )
        );
      } 
    );

  }
}