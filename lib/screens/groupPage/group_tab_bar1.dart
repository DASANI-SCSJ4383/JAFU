import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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

class _GroupTabBar1State extends State<GroupTabBar1> with AutomaticKeepAliveClientMixin{

  bool isReadmore = false;
  int activeIndex = 0;
  final ScrollController _scrollController = ScrollController();

  Future<void> getGroupPost() async {
    await widget._groupViewmodel.getGroupPost(widget._groupViewmodel.group[widget._index].groupID);
  }

  Future<void> _pullRefresh() async {
    await widget._groupViewmodel.getGroupPost(widget._groupViewmodel.group[widget._index].groupID);
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  body: RefreshIndicator(
                    onRefresh: _pullRefresh,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: widget._groupViewmodel.post.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.all(20),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,   
                            children: [
                              ListTile(
                                leading: CircleAvatar(),
                                title: Text(widget._groupViewmodel.post[index].username),
                                subtitle: Text(widget._groupViewmodel.post[index].date),
                                // trailing: Text("RM " + (double.parse(widget._groupViewmodel.post[index].price).toStringAsFixed(2)),style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5,left: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget._groupViewmodel.post[index].title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    Text("RM " + (double.parse(widget._groupViewmodel.post[index].price).toStringAsFixed(2)),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.only(right: 5,left: 5),
                                child: Column(
                                  children: [
                                    ExpandableText(
                                      widget._groupViewmodel.post[index].description,
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
                                itemCount:  widget._groupViewmodel.post[index].picture.length,
                                options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                  height: 300.sp,
                                  viewportFraction: 1,
                                  onPageChanged: (index, value) {
                                    myState(() =>
                                        activeIndex = index
                                    );
                                  }
                                ),
                                itemBuilder: (context, bil, realIdx) {
                                return InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context,'/zoompicture',arguments: widget._groupViewmodel.post[index]);
                                  },
                                  child: CachedNetworkImage(
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
                                  ),
                                );
                                
                              },
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
                                  InkWell(
                                    onTap: (){
                                      print("comment");
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(Icons.comment_rounded,color: Colors.grey,),
                                        SizedBox(width: 8),
                                        Text("Comment"),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()async{
                                      if(widget._groupViewmodel.post[index].userID == widget._userViewmodel.user.userID){
                                        Alert(
                                          context: context,
                                          type: AlertType.warning,
                                          title: "INVALID",
                                          desc: "You cannot add to cart your own item",
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
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.loading
                                        );
                                        String response = await widget._groupViewmodel.addToCart(widget._userViewmodel.user.userID, widget._groupViewmodel.post[index].postID, widget._groupViewmodel.post[index].groupID);
                                        if(response == "success"){
                                          Navigator.pop(context);
                                        }else{
                                          Navigator.pop(context);
                                          Alert(
                                          context: context,
                                          type: AlertType.warning,
                                          title: "INVALID",
                                          desc: "Item already in cart",
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
                                        }
                                      }
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(Icons.shopping_cart_checkout,color: Colors.grey),
                                        SizedBox(width: 8),
                                        Text("Add to Cart"),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()async{
                                      if(widget._groupViewmodel.post[index].userID == widget._userViewmodel.user.userID){
                                        Alert(
                                          context: context,
                                          type: AlertType.warning,
                                          title: "INVALID",
                                          desc: "You cannot chat with yourself",
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
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.loading
                                        );
                                        String id = widget._userViewmodel.user.userID;
                                        final client = chat.StreamChatCore.of(context).client;
                                        await client.disconnectUser();
                                        await client.connectUser(
                                          chat.User(
                                            id: id,
                                            extraData: {
                                              'name': widget._userViewmodel.user.username,
                                            },
                                          ),
                                          client.devToken(id).rawValue,
                                        );
                                        String sellerChat =  widget._groupViewmodel.post[index].userID;
                                        final core = chat.StreamChatCore.of(context);
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
                                          Navigator.pop(context);
                                          Navigator.of(context).push(
                                            ChannelPage.routeWithChannel(channel),
                                          );
                                        }
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
                  ),
                  floatingActionButton: FloatingActionButton.small(
                    onPressed: () {
                      if (_scrollController.hasClients) {
                        final position = _scrollController.position.minScrollExtent;
                        _scrollController.animateTo(
                          position,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                    tooltip: "Scroll to Top",
                    child: Icon(Icons.arrow_upward),
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
      textAlign: TextAlign.start,
      maxLines: lines,
    );
  }
}