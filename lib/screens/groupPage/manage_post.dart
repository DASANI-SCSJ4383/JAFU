import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:jafu/screens/chatPage/channelPage.dart';
import 'package:jafu/viewmodel/group_viewmodel.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;

class ManagePost extends StatefulWidget {

  static Route route({userviewmodel,groupViewmodel,index}) =>
      MaterialPageRoute(builder: (context) => ManagePost(userviewmodel: userviewmodel,groupViewmodel: groupViewmodel,index: index));

  final UserViewmodel _userViewmodel;
  final GroupViewmodel _groupViewmodel;
  final int _index;

  const ManagePost({userviewmodel,groupViewmodel,index}) : _userViewmodel = userviewmodel,_groupViewmodel = groupViewmodel,_index = index;

  @override
  State<ManagePost> createState() => _ManagePostState();
}

class _ManagePostState extends State<ManagePost> {

  bool isReadmore = false;
  int activeIndex = 0;

  Future<void> getMyPost() async {
    await widget._groupViewmodel.getMyPost(widget._groupViewmodel.group[widget._index].groupID,widget._userViewmodel.user.userID);
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
              return StatefulBuilder(
                builder: (thisLowerContext, myState) {
                  return Scaffold(
                    appBar: AppBar(
                        backgroundColor: Color(0xff191720),
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
                        title: Text(widget._groupViewmodel.group[widget._index].groupName),
                      ),
                    body: 
                    Column(
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.only(left: 30,top: 30),
                        //   child: Text(
                        //     "Post Management",
                        //     style: TextStyle(
                        //       fontSize: 19,
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: Padding(
                        //     padding: EdgeInsets.only(left: 30,top: 30),
                        //     child: Row(
                        //       children: [
                        //         Container(
                        //           margin: EdgeInsets.symmetric(horizontal: 10),
                        //           padding: EdgeInsets.only(left: 20),
                        //           height: 120,
                        //           width: 240,
                        //           decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.circular(15)
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: const [
                        //               Text(
                        //                 "Manage Post",style: TextStyle(fontSize: 27,color: Colors.black),
                        //               ),
                        //               SizedBox(height: 5,),
                        //               Text(
                        //                 "View, edit or delete your post",style: TextStyle(fontSize: 19,color: Colors.black),
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //         Container(
                        //           margin: EdgeInsets.symmetric(horizontal: 10),
                        //           padding: EdgeInsets.only(left: 20),
                        //           height: 120,
                        //           width: 240,
                        //           decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.circular(15)
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: const [
                        //               Text(
                        //                 "Add a post",style: TextStyle(fontSize: 27,color: Colors.black),
                        //               ),
                        //               SizedBox(height: 5,),
                        //               Text(
                        //                 "Create a new post for selling item",style: TextStyle(fontSize: 19,color: Colors.black),
                        //               )
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 10,),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 30,top: 30),
                        //   child: Text(
                        //     "Order Management",
                        //     style: TextStyle(
                        //       fontSize: 19,
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: Padding(
                        //     padding: EdgeInsets.only(left: 30,top: 30),
                        //     child: Row(
                        //       children: [
                        //         Container(
                        //           margin: EdgeInsets.symmetric(horizontal: 10),
                        //           padding: EdgeInsets.only(left: 20),
                        //           height: 120,
                        //           width: 240,
                        //           decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.circular(15)
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: const [
                        //               Text(
                        //                 "Manage Post",style: TextStyle(fontSize: 27,color: Colors.black),
                        //               ),
                        //               SizedBox(height: 5,),
                        //               Text(
                        //                 "View, edit or delete your post",style: TextStyle(fontSize: 19,color: Colors.black),
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //         Container(
                        //           margin: EdgeInsets.symmetric(horizontal: 10),
                        //           padding: EdgeInsets.only(left: 20),
                        //           height: 120,
                        //           width: 240,
                        //           decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.circular(15)
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: const [
                        //               Text(
                        //                 "Add a post",style: TextStyle(fontSize: 27,color: Colors.black),
                        //               ),
                        //               SizedBox(height: 5,),
                        //               Text(
                        //                 "Create a new post for selling item",style: TextStyle(fontSize: 19,color: Colors.black),
                        //               )
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget._groupViewmodel.post.length,
                            itemBuilder: (context, index) => Card(
                              margin: const EdgeInsets.all(10),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(),
                                      title: Text(widget._userViewmodel.user.username),
                                      subtitle: Text(widget._groupViewmodel.post[index].date),
                                      trailing: Text("RM " + (double.parse(widget._groupViewmodel.post[index].price).toStringAsFixed(2)),style: TextStyle(fontSize: 20)),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start, 
                                      children: [
                                        buildText("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
                                        isReadmore == false ?
                                      InkWell(
                                        onTap: (){
                                          myState(() {
                                            isReadmore = !isReadmore;
                                          });
                                        },
                                        child: Text("see more",style: TextStyle(color: Colors.blue),)
                                      ):Container()
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CarouselSlider.builder(
                                        itemCount:  widget._groupViewmodel.post[index].picture.length,
                                        options: CarouselOptions(
                                          enableInfiniteScroll: false,
                                          height: 300.sp,
                                          viewportFraction: 1,
                                          onPageChanged: (bil, value) {
                                            myState(() =>
                                                activeIndex = bil
                                            );
                                          }
                                        ),
                                        itemBuilder: (context, bil, realIdx) {
                                        return CachedNetworkImage(
                                          imageUrl: "http://159.223.63.41/images/" + widget._groupViewmodel.post[index].picture[bil],
                                          imageBuilder: (context,imageProvider) => Container(
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.contain),
                                            ),
                                          ),
                                          placeholder: (context, url) => Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 90.sp),
                                                child: SizedBox(
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 7.sp,
                                                  ),
                                                  width: 100.sp,
                                                  height: 100.sp
                                                ),
                                              ),
                                            ],
                                          ),
                                          errorWidget:
                                              (context, url, error) =>
                                                  Icon(Icons.error),
                                        );
                                        
                                      },
                                      ),
                                    ),
                                    Center(
                                      child: AnimatedSmoothIndicator(
                                          activeIndex: activeIndex,
                                          count: widget._groupViewmodel.post[index].picture.length,
                                          effect:
                                        ExpandingDotsEffect(
                                      dotWidth: 10,
                                      dotHeight: 10,
                                      dotColor:
                                          Colors.grey[300],
                                      activeDotColor:
                                          Colors.grey,
                                          ),
                                        )
                                    ),
                                    SizedBox(height:10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(Icons.comment_rounded,color: Colors.grey,),
                                            SizedBox(width: 8),
                                            Text("Comment"),
                                          ],
                                        ),
                                        Row(
                                          children: const [
                                            Icon(Icons.edit,color: Colors.grey,),
                                            SizedBox(width: 8),
                                            Text("Edit"),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: ()async{
                                            
                                          },
                                          child: Row(
                                            children: const [
                                              Icon(Icons.delete_forever,color: Colors.grey),
                                              SizedBox(width: 8),
                                              Text("Delete"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ) 
                          ),
                        ),
                      ],
                    ),
                  );
                }
              );
            }
          }
      }
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