// ignore_for_file: sort_child_properties_last

import 'package:festival_diary1_app/constants/color_constant.dart';
import 'package:festival_diary1_app/models/user.dart';
import 'package:festival_diary1_app/services/user_api.dart';
import 'package:festival_diary1_app/views/home_ui.dart';
import 'package:festival_diary1_app/views/register_screen_ui.dart';
import 'package:flutter/material.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPasswordCtrl = TextEditingController();

  bool isShowUserPassword = true;

  showWarningSnackBar(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Align(alignment: Alignment.center, child: Text('$msg')),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text('Festival Login',
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/images/image1.jpg',
                    width: 200,
                  ),
                  SizedBox(
                    height: 30,
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
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'รหัสผู้ใช้',
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
                    obscureText: isShowUserPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isShowUserPassword = !isShowUserPassword;
                          });
                        },
                        icon: isShowUserPassword == true
                            ? Icon(Icons.visibility_off)
                            : Icon(
                                Icons.visibility,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //Validated UI
                      if (userNameCtrl.text.isEmpty) {
                        showWarningSnackBar('ป้อนชื่อผู้ใช้ด้วย');
                      } else if (userPasswordCtrl.text.isEmpty) {
                        showWarningSnackBar('ป้อนรหัสผู้ใช้ด้วย');
                      } else {
                        //ส่งชื่อผู้ใช้และรหัสผ่าน ไปยัง API เพื่อตรวจสอบ
                        //แพ็คข้อมูลที่ต้องส่งไปให้กับ checkLogin()
                        User user = User(
                          userName: userNameCtrl.text,
                          userPassword: userPasswordCtrl.text,
                        );
                        //เรียกใช้ checkLogin()
                        user = await UserApi().checkLogin(user);
                        if (user.userID != null) {
                          //แปลว่าชื่อผู้ใช้รหัสผ่านถูกต้องเปิดไปหน้าจอ HomeUI()
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeUI(
                                        user: user,
                                      )));
                        } else {
                          //แปลว่าชื่อผู้ใช้รหัสผ่านไม่ถูกต้อง แสดง snackbar เดือน
                          showWarningSnackBar('ชื่อผู้ใช้รหัสผ่านไม่ถูกต้อง');
                        }
                      }
                    },
                    child: Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(mainColor),
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ยังไม่มีบัญชี? '),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreenUI(),
                              ));
                        },
                        child: Text('ลงทะเบียน',
                            style: TextStyle(
                              color: Color(mainColor),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Copyright © 2025',
                  ),
                  Text(
                    'Create by Willwill DTI-SAU',
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
