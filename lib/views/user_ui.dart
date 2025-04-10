// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:festival_diary1_app/constants/baseurl_constants.dart';
import 'package:festival_diary1_app/constants/color_constant.dart';
import 'package:festival_diary1_app/models/user.dart';
import 'package:festival_diary1_app/services/user_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserUI extends StatefulWidget {
  User? user;

  UserUI({super.key, this.user});

  @override
  State<UserUI> createState() => _UserUIState();
}

class _UserUIState extends State<UserUI> {
//สร้างตัวควบคุม TexField
  TextEditingController userFullNameCtrl = TextEditingController();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPasswordCtrl = TextEditingController();

//สร้างตัวแปรควบคุมการเปิดปิดตากับช่องป้อนรหัสผ่าน
  bool isVisible = true;

  //ตัวแปรเก็บรูปที่ถ่าย
  File? userFile;

  //เมธอดเปิดกล้องเพื่อถ่ายรูป
  Future<void> openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    //ตรวจสอบว่าได้ถ่ายมั้ย
    if (image == null) return;

    //หากถ่ายให้เอารูปที่ถ่ายไปเก็บในตัวแปรที่สร้างไว้
    //โดยการแปลงรูปที่ถ่ายเป็นไฟล์
    setState(() {
      userFile = File(image.path);
    });
  }

  //เมธอดแสดง SnackBar คำเตือน
  showWarningSnackBar(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Align(alignment: Alignment.center, child: Text('$msg')),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  showCompleteSnackBar(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Align(alignment: Alignment.center, child: Text('$msg')),
        backgroundColor: const Color.fromARGB(255, 64, 212, 64),
        duration: Duration(seconds: 2),
      ),
    );
  }

  showUserInfo() async {
    setState(() {
      userFullNameCtrl.text = widget.user!.userFullName!;
      userNameCtrl.text = widget.user!.userName!;
      userPasswordCtrl.text = widget.user!.userPassword!;
    });
  }

  @override
  void initState() {
    super.initState();
    showUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text(
          'ข้อมูลผู้ใช้',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ลงทะเบียน',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      await openCamera();
                    },
                    child: userFile == null
                        ? widget.user!.userImage != ''
                            ? Image.network(
                                '$baseUrl/images/users/${widget.user!.userImage!}',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.person_add_alt_1,
                                size: 150,
                                color: Color(mainColor),
                              )
                        : Image.file(
                            userFile!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ชื่อ-นามสกุล',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: userFullNameCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.featured_play_list),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ชื่อผู้ใช้',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: userNameCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'รหัสผ่าน',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: userPasswordCtrl,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(isVisible == true
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //ส่งข้อมูลไปบันทึแก้ไขใน DB ผ่าน API ที่สร้างไว้
                      //Validated UI
                      if (userFullNameCtrl.text.trim().isEmpty) {
                        showWarningSnackBar('ป้อนชื่อนามสกุลด้วย');
                      } else if (userNameCtrl.text.trim().isEmpty) {
                        showWarningSnackBar('ป้อนชื่อผู้ใช้ด้วย');
                      } else if (userPasswordCtrl.text.trim().isEmpty) {
                        showWarningSnackBar('ป้อนรหัสผ่านด้วย');
                      } else {
                        //แพ็กข้อมูลแล้วส่งผ่าน API ไปบันทึกแก้ไขลงใน DB
                        //แพ็คข้อมูล
                        User user = User(
                          userID: widget.user!.userID,
                          userFullName: userFullNameCtrl.text.trim(),
                          userName: userNameCtrl.text.trim(),
                          userPassword: userPasswordCtrl.text.trim(),
                        );
                        user = await UserApi().updateUser(user, userFile);
                        if (user.userID != null) {
                          showCompleteSnackBar('แก้ไขเรียบร้อยแล้ว');
                          Navigator.pop(context, user);
                        } else {
                          showCompleteSnackBar('แก้ไขไม่สำเร็จ');
                        }
                      }
                    },
                    child: Text(
                      'บันทึกแก้ไขข้อมูล',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(mainColor),
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
