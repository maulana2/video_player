import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_tes/models/api_return_value.dart';
import 'package:flutter_tes/models/detail_course/response_detail_course.dart';
import 'package:flutter_tes/shared/const.dart';
import 'package:http/http.dart' as http;

class DetailCourseService {
  Future<ApiReturnValue> getDetailCourse(
      {required String term, required String entity}) async {
    var url = Uri.parse('$baseUrl/search?term=$term&entity=$entity');
    // var url = Uri.parse(
    //     'https://e6f596a1-fe04-4f12-ae32-87463594302d.mock.pstmn.io/api/v1/list-laporan-keuangan');

    // print('url kategori : $url');

    //check if connection exist
    try {
      var response = await http
          .post(
            url,
          )
          .timeout(const Duration(seconds: timeoutCont));

      var statusCode = response.statusCode;

      try {
        var result = jsonDecode(response.body);

        print('ini sevice kategori : $result');
        //check if status code 404 / 200/ 5xx
        switch (statusCode) {
          case 404:
            var error = result['error'];
            String errorMsg =
                error.reduce((value, elment) => value + ',' + ' ' + elment);
            return ApiReturnValue(code: statusCode, message: errorMsg);

          case 200:
            List<ResponseDetailCourse> detailCourse =
                ResponseDetailCourse.fromJsonList(result['results']);
            return ApiReturnValue(code: statusCode, value: detailCourse);

          default:
            return ApiReturnValue(code: statusCode, message: 'Kesalahan');
        }
      } catch (e) {
        return ApiReturnValue(code: statusCode, message: 'Kesalahan');
      }
    } on SocketException catch (e) {
      //not connected to the network exception
      return ApiReturnValue(
          code: 00, message: 'Tidak terhubung ke jaringan($e)');
    } on TimeoutException catch (e) {
      //not connected to the network exception
      return ApiReturnValue(
          code: 00, message: 'Tidak terhubung ke jaringan($e)');
    }
  }
}
