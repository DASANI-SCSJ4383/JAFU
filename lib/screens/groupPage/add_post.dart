import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jafu/models/post.dart';
import 'package:jafu/screens/widgets/constants.dart';
import 'package:jafu/viewmodel/group_viewmodel.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class AddPost extends StatefulWidget {
  static Route route({userviewmodel,groupViewmodel,index}) =>
      MaterialPageRoute(builder: (context) => AddPost(userviewmodel: userviewmodel,groupViewmodel: groupViewmodel,index: index));

  final UserViewmodel _userviewmodel;
  final GroupViewmodel _groupViewmodel;
  final int _index;

  const AddPost({userviewmodel,groupViewmodel,index}) : _userviewmodel = userviewmodel,_groupViewmodel = groupViewmodel,_index = index;

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  final name = TextEditingController();
  final price = TextEditingController();
  final detail = TextEditingController();
  int mode = 0;
  final List<File> _imageList = List.filled(3, null);
  int bil = 0;

  void selectImage(index)async{
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    final imageTemporary = File(image.path);
    _imageList[index] = imageTemporary;
    // final XFile selectedImage = await _picker.pickImage(source: ImageSource.camera);
    // if(selectedImage!=null){
    //   _imageList.add(selectedImage);
    // }
  }

  AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.grey[300],
        toolbarWidgetColor: Colors.blue,
        hideBottomControls: true,
        //lockAspectRatio: false
      );

  IOSUiSettings iosUiSettingsLocked() => IOSUiSettings(
        rotateClockwiseButtonHidden: false,
        rotateButtonsHidden: false,
      );

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (thisLowerContext, myState) {
        return WillPopScope(
          onWillPop: ()async{
            if(mode == 1){
              myState(() {
                mode = 0;
              });
            }
            else{
              Alert(
                context: context,
                type: AlertType.warning,
                title: "WARNING",
                desc: "You will need to repeat the process again.",
                buttons: [
                  DialogButton(
                    child: Text(
                      "CANCEL",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  ),
                  DialogButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/inGroup", arguments: [widget._userviewmodel,widget._groupViewmodel,widget._index]);
                    },
                    width: 120,
                  )
                ],
              ).show();
              
            }
            return false;
          },
          child: Scaffold(
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
                  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "WARNING",
                    desc: "You will need to repeat the process again.",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                      ),
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/inGroup", arguments: [widget._userviewmodel,widget._groupViewmodel,widget._index]);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                  
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
                onPressed: () async{
                  if(_imageList.length == 0){
                    Alert(
                      context: context,
                      type: AlertType.warning,
                      title: "INVALID",
                      desc: "Please add atleast one picture.",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                    ).show();
                  }else{
            
                    Post newPost = Post();
                    newPost.title = name.text;
                    newPost.price = price.text;
                    newPost.description = detail.text;
            
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.loading
                    );
            
                    String postID = await widget._groupViewmodel.createPost(newPost,widget._groupViewmodel.group[widget._index].groupID,widget._userviewmodel.user.userID);
                    if(postID != null){
                      for(int i=0;i<3;i++){
                         var uri = Uri.parse("http://159.223.63.41/uploadImage.php?id=" + postID + "&index=" + i.toString());
                         var request = http.MultipartRequest("POST", uri);
                         if (_imageList[i] != null) {
                          var pic = await http.MultipartFile.fromPath("image", _imageList[i].path);
                          request.files.add(pic);
                        }
                        await request.send();
                      }
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/inGroup", arguments: [widget._userviewmodel,widget._groupViewmodel,widget._index]);
                    }else{
                      Navigator.pop(context);
                    }
                  }
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
                      labelText: "Title/Item Name*",
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
                      labelText: "Price*",
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
                    controller: detail,
                    maxLines: 5,
                    style: kBodyText.copyWith(color: Colors.black,fontSize: 20),
                    decoration: InputDecoration(
                      hintText: "Details*",
                      labelText: "Details*",
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
                      if(name.text.isEmpty||price.text.isEmpty||detail.text.isEmpty){
                        Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "INVALID",
                          desc: "Please fill in all the textfields.",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                      }else{
                        myState(() {
                          mode = 1;
                        });
                      }
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
                  Text("You can add pictures up to 3 only",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                  SizedBox(height: 15,),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10), 
                    itemCount: _imageList.length,
                    itemBuilder: (BuildContext ctx,index){
                      return _imageList[index] != null?
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(File(_imageList[index].path)),
                          // child: Image.file(
                          //   file[index],
                          //   alignment: Alignment.center,
                          //   fit: BoxFit.contain,
                          // ),
                        )
                      ):Container();
                    }
                  ),
                  SizedBox(height: 25,),
                  ElevatedButton(
                    onPressed: ()async{
                      if(bil == 3){
                        Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "INVALID",
                          desc: "Only 3 pictures allow",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                      }else{
                        // final XFile selectedImage = await _picker.pickImage(source: ImageSource.camera);
                        // if(selectedImage!=null){
                        //   // _imageList.add(selectedImage);
                        //   _imageList[bil] = selectedImage;
                        //   bil++;
                        // }
                        final image = await ImagePicker().pickImage(source: ImageSource.camera);
                        File croppedImage = await ImageCropper().cropImage(
                          sourcePath: image.path,
                          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                          aspectRatioPresets: [CropAspectRatioPreset.square],
                          compressQuality: 70,
                          compressFormat: ImageCompressFormat.jpg,
                          androidUiSettings: androidUiSettingsLocked(),
                          iosUiSettings: iosUiSettingsLocked(),
                          // maxWidth: 1080,
                          // maxHeight: 1080,
                        );
                        if (croppedImage != null) {
                          _imageList[bil] = croppedImage;
                          myState(() {});
                        }
                        bil++;
                      }
                    },
                    child: Text("Pick Image"),
                  ),
                ],
              ),
            ),
          )
          ),
        );
      } 
    );

  }
}