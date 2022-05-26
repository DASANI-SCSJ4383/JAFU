import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';
import 'package:sizer/sizer.dart';

class MyOrderPage extends StatelessWidget {

  final UserViewmodel _userviewmodel;
  const MyOrderPage(UserViewmodel userviewmodel)
      : _userviewmodel = userviewmodel;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                      color: Colors.grey[200],
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black12,
                                ),
                                color: Colors.grey[300]),
                            padding: EdgeInsets.only(top: 10.sp, left: 18.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'My Order',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                              ],
                            ),
                          ),
    
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(top: 10.sp, left: 10.sp, right: 10.sp),
                                child: Card(
                                  elevation: 3.sp,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                                        child: Text("Muhammad Afiq")
                                      ),
                                      Divider(thickness: 1.sp),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: 3,
                                        separatorBuilder: (context, index) => Divider(thickness: 1.sp),
                                        itemBuilder: (context, bil) => Container(
                                          padding: EdgeInsets.all(10.sp),
                                          child: Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: CachedNetworkImage(
                                                      imageUrl:"https://picsum.photos/250?image=9",
                                                      height: 50.sp,
                                                      width: 50.sp,
                                                      imageBuilder: (context,imageProvider) => Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context,url) => CircularProgressIndicator(),
                                                      errorWidget:(context, url, error) => Icon(Icons.error),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Padding(
                                                      padding:EdgeInsets.symmetric(horizontal: 5.sp),
                                                      child: Column(
                                                        crossAxisAlignment:CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Latpop Acer"),
                                                          SizedBox(height: 10.sp),
                                                          Text('RM 1500'),
                                                          SizedBox(height: 10.sp),
                                                          Row(
                                                            children: [
                                                              Text('Kuantiti: '),
                                                              Text("1"),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:MainAxisAlignment.end,
                                                            children: [
                                                              Text('Jumlah: RM '),
                                                              Text("1500"),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(thickness: 1.sp),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.sp,
                                            right: 10.sp,
                                            bottom: 5.sp,
                                            top: 5.sp
                                        ),
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.end,
                                          children: [
                                            Text('Total Order: RM '),
                                            Text("1500"),
                                          ],
                                        ),
                                      ),
                                      Divider(thickness: 1.sp),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.sp,right: 10.sp,bottom: 5.sp),
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.end,
                                          children: [
                                            SizedBox( width: 10),
                                            ElevatedButton(
                                              onPressed: () {
    
                                              },
                                              child: Text('Report'),
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.red),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            ElevatedButton(
                                              onPressed: () {
                                                
                                              },
                                              child: Text('Details'),
                                              style: ButtonStyle(
                                                backgroundColor:MaterialStateProperty.all(Colors.blue),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
            ),
          ],
        ),
      ),
    );
  }
}