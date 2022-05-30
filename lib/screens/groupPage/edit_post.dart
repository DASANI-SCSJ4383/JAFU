import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:jafu/models/post.dart';
import 'package:jafu/viewmodel/group_viewmodel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

import '../../viewmodel/user_viewmodel.dart';
import '../widgets/constants.dart';

class EditPost extends StatefulWidget {

  static Route route({userviewmodel,groupViewmodel,index}) =>
      MaterialPageRoute(builder: (context) => EditPost(userviewmodel: userviewmodel,groupViewmodel: groupViewmodel,index: index));

  final UserViewmodel _userViewmodel;
  final GroupViewmodel _groupViewmodel;
  final int _index;

  const EditPost({userviewmodel,groupViewmodel,index}) : _userViewmodel = userviewmodel,_groupViewmodel = groupViewmodel,_index = index;


  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController;
  TextEditingController priceController;
  TextEditingController descController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget._groupViewmodel.post[widget._index].title);
    priceController = TextEditingController(text:widget._groupViewmodel.post[widget._index].price);
    descController = TextEditingController(text: widget._groupViewmodel.post[widget._index].description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff191720),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context,null);
          },
          icon: Image(
            width: 24,
            color: Colors.white,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
        title: Text("Edit Post"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.sp,),
              Padding(
                padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: TextFormField(
                            controller: titleController,
                            style: kBodyText.copyWith(color: Colors.white,fontSize: 20),
                            decoration: InputDecoration(
                              hintText: "Title",
                              labelText: "Title",
                              hintStyle: kBodyText,
                              labelStyle: kBodyText,
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.sp,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: TextFormField(
                            controller: priceController,
                            style: kBodyText.copyWith(color: Colors.white,fontSize: 20),
                            decoration: InputDecoration(
                              prefixText: "RM ",
                              hintText: "Price",
                              labelText: "Price",
                              labelStyle: kBodyText,
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
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.sp,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: TextFormField(
                            maxLines: 5,
                            controller: descController,
                            style: kBodyText.copyWith(color: Colors.white,fontSize: 20),
                            decoration: InputDecoration(
                              hintText: "Description",
                              labelText: "Description",
                              hintStyle: kBodyText,
                              labelStyle: kBodyText,
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    ElevatedButton(
                      onPressed: ()async{
                        String respond = null;
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.loading
                        );
                        Post _editPost = Post();
                        _editPost.postID = widget._groupViewmodel.post[widget._index].postID;
                        _editPost.title = titleController.text;
                        _editPost.price = priceController.text;
                        _editPost.description = descController.text;
                        String result = await widget._groupViewmodel.editPost(_editPost);
                        if(result == null){
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
                        }else{
                          Navigator.pop(context);
                          Alert(
                            onWillPopActive: true,
                            closeFunction: (){
                              respond = "success";
                              Navigator.pop(context);
                              Navigator.pop(context,respond);
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
                                  respond = "success";
                                  Navigator.pop(context);
                                  Navigator.pop(context,respond);
                                },
                                width: 120,
                              )
                            ],
                          ).show();
                        }
                        
                      },
                      child: Text("Save"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
