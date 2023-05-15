import 'package:flutter/material.dart';
import 'package:flutter_tes/config/provider.dart';
import 'package:flutter_tes/page/detail_course_sreen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) => MultiProvider(
        providers: providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DetailCourseScreen(),
        ),
      ),
    );
  }
}
