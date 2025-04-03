import 'package:festival_diary1_app/constants/baseurl_constants.dart';
import 'package:festival_diary1_app/constants/color_constant.dart';
import 'package:festival_diary1_app/models/user.dart';
import 'package:flutter/material.dart';

class HomeUI extends StatefulWidget {
  //สร้างตัวแปรรับค่าจากหน้า Login
  User? user;

  //เอาตัวแปลที่สร้างรับค่าจากหน้า Login
  HomeUI({super.key, this.user});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
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
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              widget.user!.userImage! == ''
                  ? ClipRRect(
                    child: Image.asset(
                        'assets/images/vegito1.jpg',
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                  )
                  : Image.network(
                      '${baseUrl}/user/images/${widget.user!.userImage!}',
                      width: 200,
                      fit: BoxFit.cover,
                    ),
              Text(
                widget.user!.userFullName!,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ));
  }
}
