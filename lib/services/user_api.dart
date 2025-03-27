//user_api.dart
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:festival_diary1_app/models/user.dart';

class UserApi {
  //สร้าง object dio เพื่อใช้เป็นตัวที่ติดต่อ API Backend
  final Dio dio = Dio();

  //สร้าง method ที่เรียกใช้ API ลงทะเบียน (เพิ่มข้อมูล user)
  Future<bool> registerUser(User user, File? userFile) async {
    try {
      //เอาข้อมูลใส่ FormData
      final formData = FormData.fromMap({
        'userFullName': user.userFullName,
        'userName': user.userName,
        'userPassword': user.userPassword,
        if (userFile != null)
          'userImage': await MultipartFile.fromFile(
            userFile.path,
            filename: userFile.path.split('/').last,
            contentType: DioMediaType('image', userFile.path.split('.').last),
          ),
      });

      //เอาข้อมูลใน FormData ส่งผ่าน API ตาม Endpoint ที่ได้กำหนดไว้
      final responseData = await dio.post(
        'http://172.17.34.13:3030/user/',
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
}
