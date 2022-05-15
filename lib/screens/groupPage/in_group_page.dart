import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:jafu/viewmodel/group_viewmodel.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InGroupPage extends StatefulWidget {

  static Route route({userViewmodel, groupViewmodel, index}) => MaterialPageRoute(
      builder: (context) =>
          InGroupPage(userViewmodel: userViewmodel, groupViewmodel: groupViewmodel, index: index));

  final UserViewmodel _userViewmodel;
  final GroupViewmodel _groupViewmodel;
  final int _index;

  const InGroupPage({userViewmodel, groupViewmodel, index})
      : _userViewmodel = userViewmodel,
        _groupViewmodel = groupViewmodel,
        _index = index;

  @override
  State<InGroupPage> createState() => _InGroupPageState();
}

class _InGroupPageState extends State<InGroupPage> {

  bool isReadmore = false;
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => DefaultTabController(
        length: 3,
        child: Scaffold(
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
            bottom: TabBar(
              tabs: const [
                Tab(icon: Icon(Icons.newspaper)),
                Tab(icon: Icon(Icons.shopping_cart)),
                Tab(icon: Icon(Icons.info)),
              ],
            ),
            title: Text(widget._groupViewmodel.group[widget._index].groupName),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(),
                          title: Text("Aidiel"),
                          subtitle: Text("8.30pm"),
                          trailing: Text("RM 15.00",style: TextStyle(fontSize: 20)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          children: [
                            buildText("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
                            isReadmore == false ?
                          InkWell(
                            onTap: (){
                              setState(() {
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
                            itemCount:  3,
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              height: 300.sp,
                              viewportFraction: 1,
                              onPageChanged: (index, value) {
                                setState(() =>
                                    activeIndex = index
                                );
                              }
                            ),
                            itemBuilder: (context, index, realIdx) {
                            return CachedNetworkImage(
                              imageUrl: "https://picsum.photos/250?image=9",
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
                              count: 3,
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
                            Row(
                              children: const [
                                Icon(Icons.chat_bubble,color: Colors.grey),
                                SizedBox(width: 8),
                                Text("Chat Now"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                  //  Container(
                  //   height: 500.0,
                  //   child: Column(
                  //     children: <Widget> [
                  //       Expanded(
                  //         child: ListTile(
                  //           leading: CircleAvatar(),
                  //           title: Text("Aidiel"),
                  //           subtitle: Text("8.30pm"),
                  //           trailing: Text("RM 15.00",style: TextStyle(fontSize: 20)),
                  //         ),
                  //       ),
                  //       Text("ASdasdasdasdasdASdasdasdasdasdASdasdasdasdasdASdasdasdasdasdASdasdasdasdasdASdasdasdasdasdASdasdasdasdasdASdasdasdasdasd",textAlign: TextAlign.start,),
                  //       Expanded(
                  //         child: Container(
                  //           margin: const EdgeInsets.all(10),
                  //           decoration: BoxDecoration(
                  //             image: DecorationImage(
                  //               image: NetworkImage("https://picsum.photos/250?image=9"),
                  //               fit: BoxFit.cover
                  //             )
                  //           ),
                  //         ), 
                  //       ),
                  //       SizedBox(
                  //         height: 14,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Row(
                  //             children: const [
                  //               Icon(Icons.comment_rounded,color: Colors.grey,),
                  //               SizedBox(width: 8),
                  //               Text("Comment"),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: const [
                  //               Icon(Icons.shopping_cart_checkout,color: Colors.grey),
                  //               SizedBox(width: 8),
                  //               Text("Add to Cart"),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: const [
                  //               Icon(Icons.chat_bubble,color: Colors.grey),
                  //               SizedBox(width: 8),
                  //               Text("Chat Now"),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(height: 12.0,)
                  //     ],
                  //   ),
                  // ),
                ) 
              ),
              Icon(Icons.shopping_cart, size: 350),
              Icon(Icons.info, size: 350),
            ],
          ),
        ),
      ),
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