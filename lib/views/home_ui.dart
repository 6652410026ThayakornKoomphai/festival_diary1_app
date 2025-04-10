import 'package:festival_diary1_app/constants/baseurl_constants.dart';
import 'package:festival_diary1_app/constants/color_constant.dart';
import 'package:festival_diary1_app/models/user.dart';
import 'package:festival_diary1_app/views/add_fest_ui.dart';
import 'package:festival_diary1_app/views/login_ui.dart';
import 'package:festival_diary1_app/views/register_screen_ui.dart';
import 'package:festival_diary1_app/views/user_ui.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginUI(),
                ),
              );
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            widget.user!.userImage! == ''
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/vegito1.jpg',
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.network(
                    '$baseUrl/user/images/${widget.user!.userImage!}',
                    width: 200,
                    fit: BoxFit.cover,
                  ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.user!.userFullName!,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserUI(
                      user: widget.user,
                    ),
                  ),
                ).then((value) {
                  setState(() {
                    widget.user = value;
                  });
                });
              },
              child: Text(
                '(Edit Profile)',
                style: TextStyle(color: Colors.redAccent, fontSize: 12),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFestUI(
                userID: widget.user!.userID!,
              ),
            ),
          );
        },
        label: Text(
          'Festival',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        icon: Icon(Icons.add),
        backgroundColor: Color(mainColor),
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
