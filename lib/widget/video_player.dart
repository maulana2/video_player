import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tes/provider/detail_course/detail_course_provider.dart';
import 'package:flutter_tes/shared/style.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final DetailCourseProvider detailProv;
  bool isShowIconVideo;
  bool isLandscape;
  VideoPlayerScreen(
      {super.key,
      required this.detailProv,
      required this.isShowIconVideo,
      required this.isLandscape});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  Future _landScape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future _normal() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isLandscape == true) {
      _landScape();
    } else {
      _normal();
    }
  }

  @override
  Widget build(BuildContext context) {
    // isShowIconVideo = false;
    print('jalan');
    return InkWell(
      onTap: () {
        widget.isShowIconVideo == true
            ? widget.detailProv.controller.pause()
            : widget.detailProv.controller.play();
        if (widget.isShowIconVideo == true) {
          setState(() {
            widget.isShowIconVideo = false;
          });
        } else {
          setState(() {
            widget.isShowIconVideo = true;
          });
        }
      },
      child: Container(
        height: widget.isLandscape ? 100.h : 30.h,
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: widget.detailProv.controller.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(widget.detailProv.controller),
              widget.isShowIconVideo == true
                  ? SizedBox()
                  : widget.isLandscape == true
                      ? _exitLandscape()
                      : SizedBox(),
              widget.isShowIconVideo == true
                  ? SizedBox()
                  : _playButtonAndReplay(widget.isShowIconVideo),
              widget.isShowIconVideo == true
                  ? SizedBox()
                  : _preview(
                      context: context,
                      vidController: widget.detailProv.controller),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 13.sp,
                  child: VideoProgressIndicator(
                    colors: VideoProgressColors(
                        backgroundColor: textInactive,
                        playedColor: primaryColor),
                    widget.detailProv.controller,
                    allowScrubbing: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _exitLandscape() {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: InkWell(
          onTap: () {
            Provider.of<DetailCourseProvider>(context, listen: false)
                .isLandscape = false;
          },
          child: Container(
            margin: EdgeInsets.only(left: 20.sp, top: 20.sp),
            height: 30.sp,
            width: 30.sp,
            child: Icon(
              Icons.highlight_remove_outlined,
              color: white,
            ),
          ),
        ),
      ),
    );
  }

  Align _preview({
    required BuildContext context,
    required VideoPlayerController vidController,
  }) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(
            bottom: 15.sp, left: defaultMargin, right: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Preview', style: TextStyle(color: white)),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20.sp),
                  padding: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: white)),
                  height: 20.sp,
                  width: 30.sp,
                  child: Text(
                    '1080P',
                    style: TextStyle(color: white),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('landscape button run');
                    Provider.of<DetailCourseProvider>(context, listen: false)
                        .isLandscape = true;
                    print(
                        'ini boolnya : ${Provider.of<DetailCourseProvider>(context, listen: false).isLandscape}');
                  },
                  child: Container(
                    height: 20.sp,
                    width: 20.sp,
                    child: Center(
                      child: Icon(
                        Icons.fullscreen,
                        color: white,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Align _playButtonAndReplay(bool isShowIcon) {
    return Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 30.sp),
              height: 25.sp,
              width: 25.sp,
              child: Icon(
                Icons.replay_rounded,
                color: white,
              ),
            ),
            ClipOval(
              child: Container(
                height: 25.sp,
                width: 25.sp,
                color: primaryColor,
                child: Icon(
                  isShowIcon ? Icons.pause : Icons.play_arrow,
                  color: white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.sp),
              height: 25.sp,
              width: 25.sp,
              child: Icon(
                Icons.refresh_rounded,
                color: white,
              ),
            )
          ],
        ));
  }
}
