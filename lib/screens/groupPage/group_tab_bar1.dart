import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;

import '../../viewmodel/group_viewmodel.dart';
import '../../viewmodel/user_viewmodel.dart';
import '../chatPage/channelPage.dart';

class GroupTabBar1 extends StatefulWidget {

  final UserViewmodel _userViewmodel;
  final GroupViewmodel _groupViewmodel;
  final int _index;
  const GroupTabBar1(UserViewmodel viewmodel,GroupViewmodel groupviewmodel,int index) : _userViewmodel = viewmodel,_groupViewmodel = groupviewmodel,_index = index;

  @override
  State<GroupTabBar1> createState() => _GroupTabBar1State();
}

class _GroupTabBar1State extends State<GroupTabBar1> {

  bool isReadmore = false;
  int activeIndex = 0;

  Future<void> getGroupPost() async {
    await widget._groupViewmodel.getGroupPost(widget._groupViewmodel.group[widget._index].groupID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getGroupPost(),
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
                  body: ListView.builder(
                    itemCount: widget._groupViewmodel.post.length,
                    itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.all(20),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(),
                              title: Text(widget._groupViewmodel.post[index].username),
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
                                    Icon(Icons.shopping_cart_checkout,color: Colors.grey),
                                    SizedBox(width: 8),
                                    Text("Add to Cart"),
                                  ],
                                ),
                                InkWell(
                                  onTap: ()async{
                                    String sellerChat = "3";
                                    final core =
                                        chat.StreamChatCore.of(context);
                                    final channel = core.client.channel(
                                        'messaging',
                                        extraData: {
                                          'members': [
                                            core.currentUser.id,
                                            sellerChat,
                                          ]
                                        });
                                    final state = await channel.watch();
                    
                                    if (state != null) {
                                      Navigator.of(context).push(
                                        ChannelPage.routeWithChannel(channel),
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(Icons.chat_bubble,color: Colors.grey),
                                      SizedBox(width: 8),
                                      Text("Chat Now"),
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