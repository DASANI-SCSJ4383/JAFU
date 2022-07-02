import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../viewmodel/group_viewmodel.dart';
import '../model/post.dart';
import '../model/post_provider.dart';

class GroupPost extends StatefulWidget {
  @override
  State<GroupPost> createState() => _GroupPostState();
}

class _GroupPostState extends State<GroupPost>
    with AutomaticKeepAliveClientMixin {
  bool isReadmore = false;
  int activeIndex = 0;
  final ScrollController _scrollController = ScrollController();

  List<Post> _post = [];

  Future<void> getGroupPost() async {
    GroupViewmodel _viewmodel = GroupViewmodel();
    _post = await _viewmodel.getGroupPost("5");
    // Provider.of<PostProvider>(context, listen: false).setPost(_post);
  }

  // Future _pullRefresh() async {
  //   await widget._groupViewmodel.getGroupPost(widget._groupViewmodel.group[widget._index].groupID);
  //   setState(() {});
  // }

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
              return StatefulBuilder(builder: (thisLowerContext, myState) {
                return Scaffold(
                  body: RefreshIndicator(
                    onRefresh: getGroupPost,
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _post.length,
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
                                    title: Text("Username"),
                                    subtitle: Text(_post[index].date),
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
                                          _post[index].title,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("RM " + _post[index].price,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
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
                                          _post[index].description,
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
                                        onPageChanged: (index, value) {
                                          myState(() => activeIndex = index);
                                        }),
                                    itemBuilder: (context, bil, realIdx) {
                                      return InkWell(
                                        onTap: () {},
                                        child: CachedNetworkImage(
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
                                          placeholder: (context, url) => Stack(
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
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
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
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.comment_rounded,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(width: 8),
                                            Text("Comment"),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {},
                                        child: Row(
                                          children: const [
                                            Icon(Icons.shopping_cart_checkout,
                                                color: Colors.grey),
                                            SizedBox(width: 8),
                                            Text("Add to Cart"),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {},
                                        child: Row(
                                          children: const [
                                            Icon(Icons.chat_bubble,
                                                color: Colors.grey),
                                            SizedBox(width: 8),
                                            Text("Chat Now"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ))),
                  ),
                  floatingActionButton: FloatingActionButton.small(
                    onPressed: () {
                      if (_scrollController.hasClients) {
                        final position =
                            _scrollController.position.minScrollExtent;
                        _scrollController.animateTo(
                          position,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeOut,
                        );
                      }
                      // getGroupPost();
                    },
                    tooltip: "Scroll to Top",
                    child: Icon(Icons.arrow_upward),
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
      textAlign: TextAlign.start,
      maxLines: lines,
    );
  }
}
