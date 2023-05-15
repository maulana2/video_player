import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tes/provider/detail_course/detail_course_provider.dart';
import 'package:video_player/video_player.dart';

class VideoProvider with ChangeNotifier {
  late VideoPlayerController controller;
  String? _videoUrl =
      'https://video-ssl.itunes.apple.com/itunes-assets/Video115/v4/f0/92/0c/f0920ce2-8bb7-5e62-b44c-36ce701fe7b1/mzvf_6922739671336234286.640x352.h264lc.U.p.m4v';
  String? get videoUrl => _videoUrl;
  set videoUrl(String? videoUrl) {
    _videoUrl = videoUrl;
    notifyListeners();
  }

  bool _isShowIconVideo = false;
  bool get isShowIconVideo => _isShowIconVideo;
  set isShowIconVideo(bool isShowIconVideo) {
    _isShowIconVideo = isShowIconVideo;
    notifyListeners();
  }

  bool isInit = false;

  bool _isLandScape = false;
  bool get isLandScape => _isLandScape;
  set isLandScape(bool isLandScape) {
    _isLandScape = isLandScape;
    notifyListeners();
  }

  Future playVideo() async {
    controller = await VideoPlayerController.network(videoUrl.toString())
      ..initialize().then((value) {
        isInit = true;
        print('jalan');
        controller.play();
        notifyListeners();
      });

    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    // controller.setLooping(true);
    // controller.addListener(() {});
  }

  Future landScapeMode() async {
    if (_isLandScape == false) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      _isLandScape = true;
    } else {
      await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      _isLandScape = false;
    }
  }

  Future<void> hideIconVideo() async {
    Future.delayed(
      Duration(seconds: 5),
      () {
        isShowIconVideo = false;
        notifyListeners();
      },
    );
  }
}
