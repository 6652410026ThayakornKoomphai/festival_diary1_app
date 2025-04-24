import 'package:festival_diary1_app/constants/baseurl_constants.dart';
import 'package:festival_diary1_app/constants/color_constant.dart';
import 'package:festival_diary1_app/models/fest.dart';
import 'package:festival_diary1_app/models/user.dart';
import 'package:festival_diary1_app/services/fest_api.dart';
import 'package:festival_diary1_app/views/add_fest_ui.dart';
import 'package:festival_diary1_app/views/edit_del_fest_ui.dart';
import 'package:festival_diary1_app/views/login_ui.dart';
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
  //สร้างตัวแปรรับค่าข้อมูล fest ที่ได้จากการดึงค่าฐานข้อมูลผ่าน API
  late Future<List<Fest>> festAllData;

  //สร้างmethod ดึงข้อมูล fest ทั้งหมดของผู้ใช้งานที่ login เข้ามาจาก API
  Future<List<Fest>> getAllFestByUserFromHomeUI() async {
    final festData = await FestApi().getAllFestByUser(widget.user!.userID!);
    return festData;
  }

  @override
  void initState() {
    super.initState();
    festAllData = getAllFestByUserFromHomeUI();
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
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                future: festAllData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          'พบปัญหาในการทำงาน ลองใหม่อีกครั้ง: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditDelFestUI(
                                    fest: snapshot.data![index],
                                  ),
                                ),
                              ).then((value) {
                                setState(() {
                                  festAllData = getAllFestByUserFromHomeUI();
                                });
                              });
                            },
                            leading: snapshot.data![index].festImage! == ""
                                ? Image.asset('assets/images/image1.jpg')
                                : Image.network(
                                    '${baseUrl}/images/fests/${snapshot.data![index].festImage!}',
                                    width: 50,
                                  ),
                            title: Text(
                              snapshot.data![index].festName!,
                            ),
                            subtitle: Text(
                              snapshot.data![index].festDetail!,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          );
                        });
                  } else {
                    return Center(
                      child: Text('ไม่มีข้อมูล'),
                    );
                  }
                },
              ),
            ),
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
          ).then((value) {
            setState(() {
              festAllData = getAllFestByUserFromHomeUI();
            });
          });
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
