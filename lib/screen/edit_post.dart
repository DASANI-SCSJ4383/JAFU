import 'package:assingment_2/model/post.dart';
import 'package:assingment_2/screen/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../viewmodel/user_viewmodel.dart';
import '../viewmodel/group_viewmodel.dart';

class EditPost extends StatefulWidget {
  final UserViewmodel _userViewmodel;
  final GroupViewmodel _groupViewmodel;
  final int _index;

  const EditPost(userviewmodel, groupViewmodel, index)
      : _userViewmodel = userviewmodel,
        _groupViewmodel = groupViewmodel,
        _index = index;

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
    titleController = TextEditingController(
        text: widget._groupViewmodel.post[widget._index].title);
    priceController = TextEditingController(
        text: widget._groupViewmodel.post[widget._index].price);
    descController = TextEditingController(
        text: widget._groupViewmodel.post[widget._index].description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff191720),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, null);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text("Edit Post"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
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
                            style: kBodyText.copyWith(
                                color: Colors.white, fontSize: 20),
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
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: TextFormField(
                            controller: priceController,
                            style: kBodyText.copyWith(
                                color: Colors.white, fontSize: 20),
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
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: TextFormField(
                            maxLines: 5,
                            controller: descController,
                            style: kBodyText.copyWith(
                                color: Colors.white, fontSize: 20),
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
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Post _editPost = Post();
                        _editPost.postID =
                            widget._groupViewmodel.post[widget._index].postID;
                        _editPost.title = titleController.text;
                        _editPost.price = priceController.text;
                        _editPost.description = descController.text;
                        String result =
                            await widget._groupViewmodel.editPost(_editPost);
                        if (result != null) {
                          // print("success");
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
