import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

import '../../viewmodel/group_viewmodel.dart';
import '../../viewmodel/user_viewmodel.dart';

class GroupTabBar3 extends StatefulWidget {

  final UserViewmodel _userViewmodel;
  final GroupViewmodel _groupViewmodel;
  final int _index;
  const GroupTabBar3(UserViewmodel viewmodel,GroupViewmodel groupviewmodel,int index) : _userViewmodel = viewmodel,_groupViewmodel = groupviewmodel,_index = index;

  @override
  State<GroupTabBar3> createState() => _GroupTabBar3State();
}

class _GroupTabBar3State extends State<GroupTabBar3> {

  double total = 0;

  Future<void> getCart() async {
    await widget._groupViewmodel.getCart(widget._groupViewmodel.group[widget._index].groupID,widget._userViewmodel.user.userID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCart(),
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
                    body: SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(2.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20,),
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widget._groupViewmodel.cart.length,
                                shrinkWrap: true,
                                separatorBuilder: (context, bil) =>  Divider(color: Colors.grey),
                                itemBuilder: (context, bil) => Slidable(
                                  actionPane:SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.25,
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
                                                value: widget._groupViewmodel.cart[bil].selected,
                                                onChanged:(bool value) {
                                                  if(widget._groupViewmodel.cart[bil].selected == true){
                                                    total = total - double.parse(widget._groupViewmodel.cart[bil].price);
                                                  }else{
                                                    total = total + double.parse(widget._groupViewmodel.cart[bil].price);
                                                  }
                                                  widget._groupViewmodel.cart[bil].selected = !widget._groupViewmodel.cart[bil].selected;
                                                  myState(() {});
                                                }
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: CachedNetworkImage(
                                              imageUrl:  "http://159.223.63.41/images/" + widget._groupViewmodel.cart[bil].pic1,
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
                                                  Text(widget._groupViewmodel.cart[bil].title,
                                                    style: TextStyle(color: Colors.black),
                                                    overflow:TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height:5.sp),
                                                  Text(
                                                    'RM ' + double.parse(widget._groupViewmodel.cart[bil].price).toStringAsFixed(2),
                                                    style: TextStyle(
                                                        fontWeight:FontWeight.bold,
                                                        color: Colors.black
                                                    ),
                                                  ),
                                                  // SizedBox(height:5.sp),
                                                  // Row(
                                                  //   children: [
                                                  //     InkWell(
                                                  //       onTap:() async {},
                                                  //       child:Container(
                                                  //         height:20.sp,
                                                  //         width:20.sp,
                                                  //         decoration:BoxDecoration(
                                                  //           border:Border.all(
                                                  //             width: 1,
                                                  //             color: Colors.black,
                                                  //           ),
                                                  //         ),
                                                  //         child:Icon(Icons.remove,color: Colors.black,),
                                                  //       ),
                                                  //     ),
                                                  //     Container(
                                                  //         height: 20.sp,
                                                  //         width: 20.sp,
                                                  //         // decoration:BoxDecoration(
                                                  //         //   border:Border.all(
                                                  //         //     width: 1,
                                                  //         //     color: Colors.black12,
                                                  //         //   ),
                                                  //         // ),
                                                  //         child:Center(
                                                  //           child: Text("12",style: TextStyle(color: Colors.black))
                                                  //         )
                                                  //     ),
                                                  //     InkWell(
                                                  //       onTap:
                                                  //           () async {},
                                                  //       child:Container(
                                                  //         height:20.sp,
                                                  //         width:20.sp,
                                                  //         decoration:BoxDecoration(
                                                  //           border:Border.all(
                                                  //             width: 1,
                                                  //             color: Colors.black,
                                                  //           ),
                                                  //         ),
                                                  //         child:Icon(Icons.add,color: Colors.black),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
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
                                              text: "RM " + total.toStringAsFixed(2),
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
                  );
                }
              );
            }
          }
      },
    );
  }
}