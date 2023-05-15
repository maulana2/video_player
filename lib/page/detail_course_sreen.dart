import 'package:flutter/material.dart';
import 'package:flutter_tes/models/detail_course/response_detail_course.dart';
import 'package:flutter_tes/provider/detail_course/detail_course_provider.dart';
import 'package:flutter_tes/widget/video_player.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../shared/style.dart';

class DetailCourseScreen extends StatelessWidget {
  const DetailCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<DetailCourseProvider>(context, listen: false)
            .getDetailCourse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Consumer<DetailCourseProvider>(
              builder: (context, detailProv, child) {
                if (detailProv.listResponseDetailCourse.isNotEmpty) {
                  if (detailProv.isLandscape == false) {
                    print('build landscape false');

                    return Column(
                      children: [
                        detailProv.videoPlay == true
                            ? VideoPlayerScreen(
                                isLandscape: false,
                                isShowIconVideo: true,
                                detailProv: detailProv,
                              )
                            : SizedBox(),
                        Expanded(
                          child: Container(
                            child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10.sp,
                              ),
                              itemCount:
                                  detailProv.listResponseDetailCourse.length,
                              itemBuilder: (context, index) {
                                return _itemVideo(
                                    detailProv: detailProv,
                                    detailModel: detailProv
                                        .listResponseDetailCourse[index]);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    print('build landscape true');
                    return VideoPlayerScreen(
                        isLandscape: true,
                        detailProv: detailProv,
                        isShowIconVideo: false);
                  }
                } else {
                  return Center(
                    child: Text('Tidak ada data'),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}

_itemVideo(
    {required ResponseDetailCourse detailModel,
    required DetailCourseProvider detailProv}) {
  int? millisToMinutes(int millis) {
    return (millis / 60000).floor();
  }

  String timeInMinutes =
      millisToMinutes(detailModel.trackTimeMillis!).toString();
  return InkWell(
    onTap: () async {
      await detailProv.onClick(videoUrl: detailModel.previewUrl.toString());
    },
    child: Container(
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
          border: Border.all(
        color: textInactive,
      )),
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
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
                SizedBox(
                  width: 15.sp,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(detailModel.trackName.toString(),
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis),
                      Text(detailModel.artistName.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text('${timeInMinutes} Min'),
        ],
      ),
    ),
  );
}
