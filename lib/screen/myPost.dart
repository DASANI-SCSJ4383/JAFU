import 'package:assingment_2/model/post.dart';
import 'package:assingment_2/screen/edit_post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../viewmodel/group_viewmodel.dart';
import '../viewmodel/user_viewmodel.dart';

class MyPost extends StatefulWidget {
  final UserViewmodel _userViewmodel;

  const MyPost(userviewmodel) : _userViewmodel = userviewmodel;

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  bool isReadmore = false;
  int activeIndex = 0;
  List<Post> _post = [];
  GroupViewmodel _viewmodel = GroupViewmodel();

  Future<void> getMyPost() async {
    await _viewmodel.getMyPost("5", "4");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMyPost(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Color(0xff191720),
              body: Center(
                child: SpinKitRotatingCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return StatefulBuilder(builder: (thisLowerContext, myState) {
                return Scaffold(
                  body: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: 2,
                            itemBuilder: (context, index) => Card(
                                margin: const EdgeInsets.all(10),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(),
                                        title: Text("Username"),
                                        subtitle:
                                            Text(_viewmodel.post[index].date),
                                        // trailing: Text("RM " + (double.parse(widget._groupViewmodel.post[index].price).toStringAsFixed(2)),style: TextStyle(fontSize: 20)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5, left: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _viewmodel.post[index].title,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                "RM " +
                                                    _viewmodel
                                                        .post[index].price,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5, left: 5),
                                        child: Column(
                                          children: [
                                            ExpandableText(
                                              _viewmodel
                                                  .post[index].description,
                                              expandText: 'show more',
                                              // collapseText: '\nshow less',
                                              maxLines: 3,
                                              linkColor: Colors.blue,
                                            ),
                                            // buildText(widget._groupViewmodel.post[index].description),
                                          ],
                                        ),
                                      ),
                                      CarouselSlider.builder(
                                        itemCount: 2,
                                        options: CarouselOptions(
                                            enableInfiniteScroll: false,
                                            height: 300,
                                            viewportFraction: 1,
                                            onPageChanged: (bil, value) {
                                              myState(() => activeIndex = bil);
                                            }),
                                        itemBuilder: (context, bil, realIdx) {
                                          return CachedNetworkImage(
                                            imageUrl:
                                                "https://images.unsplash.com/photo-1573890990305-0ab6a7195ab6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.contain),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 90),
                                                  child: SizedBox(
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 7,
                                                      ),
                                                      width: 100,
                                                      height: 100),
                                                ),
                                              ],
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          );
                                        },
                                      ),
                                      Center(
                                          child: AnimatedSmoothIndicator(
                                        activeIndex: activeIndex,
                                        count: 2,
                                        effect: ExpandingDotsEffect(
                                          dotWidth: 10,
                                          dotHeight: 10,
                                          dotColor: Colors.grey[300],
                                          activeDotColor: Colors.grey,
                                        ),
                                      )),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          // InkWell(
                                          //   onTap: (){

                                          //   },
                                          //   child: Row(
                                          //     children: const [
                                          //       Icon(Icons.comment_rounded,color: Colors.grey,),
                                          //       SizedBox(width: 8),
                                          //       Text("Comment"),
                                          //     ],
                                          //   ),
                                          // ),
                                          InkWell(
                                            onTap: () async {
                                              final result =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPost(
                                                            widget
                                                                ._userViewmodel,
                                                            _viewmodel,
                                                            index)),
                                              );
                                              if (result != null) {
                                                setState(() {});
                                              }
                                            },
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.edit_sharp,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(width: 8),
                                                Text("Edit"),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {},
                                            child: InkWell(
                                              onTap: () {},
                                              child: Row(
                                                children: const [
                                                  Icon(Icons.delete_forever,
                                                      color: Colors.grey),
                                                  SizedBox(width: 8),
                                                  Text("Delete"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))),
                      ),
                    ],
                  ),
                );
              });
            }
          }
        });
  }

  Widget buildText(String text) {
    final lines = isReadmore ? null : 3;

    return Text(
      text,
      maxLines: lines,
    );
  }
}
