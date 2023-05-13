import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';

import '../shared/style.dart';

class DetailCourse extends StatefulWidget {
  const DetailCourse({super.key});

  @override
  State<DetailCourse> createState() => _DetailCourseState();
}

class _DetailCourseState extends State<DetailCourse> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      "https://video-ssl.itunes.apple.com/itunes-assets/Video115/v4/f0/92/0c/f0920ce2-8bb7-5e62-b44c-36ce701fe7b1/mzvf_6922739671336234286.640x352.h264lc.U.p.m4v",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: 30.h,
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 16,
                child: VideoPlayer(_controller),
              )),
          Expanded(
            child: Container(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.sp,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return _itemVideo();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

_itemVideo() {
  return Container(
    padding: EdgeInsets.all(15.sp),
    decoration: BoxDecoration(
        border: Border.all(
      color: textInactive,
    )),
    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipOval(
              child: Container(
                color: primaryColor,
                height: 25.sp,
                width: 25.sp,
                child: Icon(
                  Icons.play_arrow,
                  color: white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Apa itu leadership'),
                  Text('Video'),
                ],
              ),
            ),
          ],
        ),
        Text('5 Min')
      ],
    ),
  );
}
