import 'package:flutter_tes/provider/detail_course/detail_course_provider.dart';
import 'package:flutter_tes/provider/detail_course/video_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<DetailCourseProvider>(
    create: (context) => DetailCourseProvider(),
  ),
  ChangeNotifierProvider<VideoProvider>(
    create: (context) => VideoProvider(),
  ),
];
