import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
        length: 4,
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
                Tab(icon: Icon(Icons.my_library_add)),
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
                ) 
              ),
              Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/addPost",arguments: widget._userViewmodel);
                  },
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add),
                ),
              ),
              Scaffold(
                body: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(2.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          shrinkWrap: true,
                          separatorBuilder: (context, bil) =>  Divider(color: Colors.grey),
                          itemBuilder: (context, bil) => Slidable(
                            actionPane:SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            child: Container(
                              child: Column(
                                mainAxisAlignment:MainAxisAlignment.start,
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Checkbox(
                                            value: true,
                                            onChanged:(bool value) {
                                              
                                            }
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: CachedNetworkImage(
                                          imageUrl: "https://picsum.photos/250?image=9",
                                          height: 60.sp,
                                          imageBuilder:(context, imageProvider) =>  Container(
                                            decoration:BoxDecoration(
                                              borderRadius:BorderRadius.circular(10),
                                              image:DecorationImage(
                                                image:imageProvider,
                                                fit: BoxFit.contain,
                                              )
                                            ),
                                          ),
                                          placeholder: (context, url) => CircularProgressIndicator(),
                                          errorWidget: (context,url,error) => Icon(Icons.error),
                                        )
                                      ),
                                      SizedBox(width: 25,),
                                      Expanded(
                                        flex: 6,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal:8.sp),
                                          child: Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                              Text("Aasdasd",
                                                style: TextStyle(color: Colors.black),
                                                overflow:TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height:5.sp),
                                              Text(
                                                'RM ',
                                                style: TextStyle(
                                                    fontWeight:FontWeight.bold,
                                                    color: Colors.black
                                                ),
                                              ),
                                              SizedBox(height:5.sp),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap:() async {},
                                                    child:Container(
                                                      height:20.sp,
                                                      width:20.sp,
                                                      decoration:BoxDecoration(
                                                        border:Border.all(
                                                          width: 1,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      child:Icon(Icons.remove,color: Colors.black,),
                                                    ),
                                                  ),
                                                  Container(
                                                      height: 20.sp,
                                                      width: 20.sp,
                                                      // decoration:BoxDecoration(
                                                      //   border:Border.all(
                                                      //     width: 1,
                                                      //     color: Colors.black12,
                                                      //   ),
                                                      // ),
                                                      child:Center(
                                                        child: Text("12",style: TextStyle(color: Colors.black))
                                                      )
                                                  ),
                                                  InkWell(
                                                    onTap:
                                                        () async {},
                                                    child:Container(
                                                      height:20.sp,
                                                      width:20.sp,
                                                      decoration:BoxDecoration(
                                                        border:Border.all(
                                                          width: 1,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      child:Icon(Icons.add,color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ),
                                      // SizedBox(width: 25,),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.sp)
                                ],
                              ),
                            ),
                            secondaryActions: [
                              IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {},
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                  color: Color(0xff191720),
                  height: 50.sp,
                  child:StatefulBuilder(
                    builder: (context, StateSetter bottomState) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text.rich(
                                  TextSpan(
                                    text: "Total:\n",
                                    style: TextStyle(color: Colors.white),
                                    children: [
                                      TextSpan(
                                          text: "RM ",
                                          style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold,color: Colors.white)
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: FloatingActionButton.extended(
                                  onPressed: () async {},
                                  backgroundColor: Colors.blue,
                                  label: Row(
                                    children: [
                                      Text('Checkout'),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  )
                ),
              ),
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