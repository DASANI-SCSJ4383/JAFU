import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/post.dart';

class ZoomPicture extends StatefulWidget {
  static Route route({post}) =>
      MaterialPageRoute(builder: (context) => ZoomPicture(post: post));
  
  final Post _post;

  const ZoomPicture({post}) : _post = post;

  @override
  State<ZoomPicture> createState() => _ZoomPictureState();
}

class _ZoomPictureState extends State<ZoomPicture> {
  int currentIndex = 0;

  void onPageChange(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: widget._post.picture.length,
            builder: (BuildContext picture, index) =>
                PhotoViewGalleryPageOptions(
              imageProvider:
                  NetworkImage('http://159.223.63.41/images/' + widget._post.picture[index]),
              minScale: PhotoViewComputedScale.contained * 1,
              maxScale: PhotoViewComputedScale.covered * 1.8,
              initialScale: PhotoViewComputedScale.contained,
            ),
            onPageChanged: onPageChange,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.blue,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.h, left: 44.w),
            child: AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: widget._post.picture.length,
              effect: JumpingDotEffect(
                dotWidth: 8,
                dotHeight: 8,
                dotColor: Colors.grey[300],
                activeDotColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
