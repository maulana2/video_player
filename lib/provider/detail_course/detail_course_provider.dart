import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tes/models/api_return_value.dart';
import 'package:flutter_tes/models/detail_course/response_detail_course.dart';
import 'package:flutter_tes/services/detail_course/detail_course_service.dart';
import 'package:video_player/video_player.dart';

class DetailCourseProvider with ChangeNotifier {
  late VideoPlayerController controller;
  late String _message;
  String get message => _message;

  late int _code;
  int get code => _code;
  bool _videoPlay = false;
  bool get videoPlay => _videoPlay;

  bool _isLandscape = false;
  bool get isLandscape => _isLandscape;
  set isLandscape(bool isLandscape) {
    _isLandscape = isLandscape;
    notifyListeners();
  }

  List<ResponseDetailCourse> _listResponseDetailCourse = [];
  List<ResponseDetailCourse> get listResponseDetailCourse =>
      _listResponseDetailCourse;

  Future getDetailCourse() async {
    String term = 'jack+johnson';
    String entity = 'musicVideo';
    ApiReturnValue result =
        await DetailCourseService().getDetailCourse(term: term, entity: entity);

    var stCode = result.code;
    print(stCode);
    switch (stCode) {
      case 200:
        _code = stCode!;
        _message = result.message.toString();
        _listResponseDetailCourse = result.value;

        notifyListeners();

        break;
      default:
        _code = stCode!;
        _message = result.message!;
        notifyListeners();
        print('xxx kategori');
    }
  }

  Future<void> onClick({required String videoUrl}) async {
    controller = VideoPlayerController.network(videoUrl.toString())
      ..initialize().then((value) {
        _videoPlay = true;
        notifyListeners();
        controller.play();
        notifyListeners();
      });

    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    // controller.setLooping(true);
    // controller.addListener(() {});
  }
}
