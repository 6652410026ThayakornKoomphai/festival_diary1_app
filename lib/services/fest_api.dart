//user_api.dart
// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:festival_diary1_app/constants/baseurl_constants.dart';
import 'package:festival_diary1_app/models/fest.dart';

class FestApi {
  //สร้าง object dio เพื่อใช้เป็นตัวที่ติดต่อ API Backend
  final Dio dio = Dio();

  //สร้าง method ที่เรียกใช้ API ลงทะเบียน (เพิ่มข้อมูล user)
  Future<bool> addFest(Fest fest, File? festFile) async {
    try {
      //เอาข้อมูลใส่ FormData
      final formData = FormData.fromMap({
        'festName': fest.festName,
        'festDetail': fest.festDetail,
        'festState': fest.festState,
        'festNumDay': fest.festNumDay,
        'festCost': fest.festCost,
        'userID': fest.userID,
        if (festFile != null)
          'festImage': await MultipartFile.fromFile(
            festFile.path,
            filename: festFile.path.split('/').last,
            contentType: DioMediaType('image', festFile.path.split('.').last),
          ),
      });

      //เอาข้อมูลใน FormData ส่งผ่าน API ตาม Endpoint ที่ได้กำหนดไว้
      final responseData = await dio.post(
        '${baseUrl}/fest/',
        data: formData,
        options: Options(headers: {
          'Content-type': 'multipart/from-data',
        }),
      );
      //หลังจากทำงานเสร็จ ณ ทีนี้ตรวจสอบผลการทำงานจาก responseData
      if (responseData.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  Future<List<Fest>> getAllFestByUser(int userID) async {
    try {
      final responseData = await dio.get('${baseUrl}/fest/${userID}');

      if (responseData.statusCode == 200) {
        return (responseData.data["info"] as List)
            .map((e) => Fest.fromJson(e))
            .toList();
      } else {
        return <Fest>[];
      }
    } catch (e) {
      print('Exception: $e');
      return <Fest>[];
    }
  }

  Future<bool> updateFest(Fest fest, File? festFile) async {
    try {
      final formData = FormData.fromMap({
        'festName': fest.festName,
        'festDetail': fest.festDetail,
        'festState': fest.festState,
        'festCost': fest.festCost,
        'userID': fest.userID,
        'festNumDay': fest.festNumDay,
        if (festFile != null)
          'festImage': await MultipartFile.fromFile(festFile.path,
              filename: festFile.path.split('/').last,
              contentType:
                  DioMediaType('image', festFile.path.split('.').last)),
      });

      final responseData = await dio.put(
        '$baseUrl/fest/${fest.festID}',
        data: formData,
        options: Options(
          headers: {
            'content-type': 'multipart/form-data',
          },
        ),
      );

      if (responseData.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('ERROR: ${err.toString()}');
      return false;
    }
  }

  //สร้างเมธอดเรียกใช้ API ลบข้อมูล fest
  Future<bool> deleteFest(int festId) async {
    try {
      final responseData = await dio.delete(
        '${baseUrl}/fest/${festId}',
      );

      if (responseData.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Exception: ${err}');
      return false;
    }
  }
}
