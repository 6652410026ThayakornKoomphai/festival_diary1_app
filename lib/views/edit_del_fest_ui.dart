// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:festival_diary1_app/constants/baseurl_constants.dart';
import 'package:festival_diary1_app/constants/color_constant.dart';
import 'package:festival_diary1_app/models/fest.dart';
import 'package:festival_diary1_app/services/fest_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditDelFestUI extends StatefulWidget {
  Fest? fest;
  EditDelFestUI({super.key, this.fest});

  @override
  State<EditDelFestUI> createState() => _EditDelFestUIState();
}

class _EditDelFestUIState extends State<EditDelFestUI> {
  File? festFile;

  TextEditingController festNameCtrl = TextEditingController();
  TextEditingController festDetailCtrl = TextEditingController();
  TextEditingController festStateCtrl = TextEditingController();
  TextEditingController festNumDayCtrl = TextEditingController();
  TextEditingController festCostCtrl = TextEditingController();

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

  Future<void> openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    //ตรวจสอบว่าได้ถ่ายมั้ย
    if (image == null) return;

    //หากถ่ายให้เอารูปที่ถ่ายไปเก็บในตัวแปรที่สร้างไว้
    //โดยการแปลงรูปที่ถ่ายเป็นไฟล์
    setState(() {
      festFile = File(image.path);
    });
  }

  @override
  void initState() {
    super.initState();
    festNameCtrl.text = widget.fest!.festName!;
    festDetailCtrl.text = widget.fest!.festDetail!;
    festStateCtrl.text = widget.fest!.festState!;
    festNumDayCtrl.text = widget.fest!.festNumDay!.toString();
    festCostCtrl.text = widget.fest!.festCost!.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text('ข้อมูล Festival Diary',
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
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
                      'รายละเอียด Festival',
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
                      child: festFile == null
                          ? widget.fest!.festImage! == ''
                              ? Image.asset(
                                  'assets/images/image1.jpg',
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  '${baseUrl}/images/fests/${widget.fest!.festImage!}',
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                          : Image.file(
                              festFile!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ชื่องาน Festival',
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
                      controller: festNameCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.mode_of_travel_sharp),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'รายละเอียดงาน Festival',
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
                      controller: festDetailCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.info_outline),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'สถานที่จัดงาน Festival',
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
                      controller: festStateCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.house),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'จัดงานกี่วัน Festival',
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
                      controller: festNumDayCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ค่าตั๋ว Festival',
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
                      controller: festCostCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (festNameCtrl.text.trim().isEmpty) {
                          showWarningSnackBar('ป้อนชื่องานด้วย');
                        } else if (festDetailCtrl.text.trim().isEmpty) {
                          showWarningSnackBar('ป้อนรายละเอียดด้วย');
                        } else if (festStateCtrl.text.trim().isEmpty) {
                          showWarningSnackBar('ป้อนสถานที่ด้วย');
                        } else if (festNumDayCtrl.text.trim().isEmpty) {
                          showWarningSnackBar('ป้อนจำนวนวันด้วย');
                        } else if (festCostCtrl.text.trim().isEmpty) {
                          showWarningSnackBar('ป้อนค่าตั๋วด้วย');
                        } else {
                          Fest fest = Fest(
                            festName: festNameCtrl.text.trim(),
                            festDetail: festNumDayCtrl.text.trim(),
                            festState: festStateCtrl.text.trim(),
                            festCost: double.parse(festCostCtrl.text.trim()),
                            userID: widget.fest!.userID!,
                            festNumDay: int.parse(festNumDayCtrl.text.trim()),
                            festID: widget.fest!.festID,
                          );
                          if (await FestApi().updateFest(fest, festFile)) {
                            showCompleteSnackBar('บันทึกแก้ไขเรียบร้อยแล้ว');
                            Navigator.pop(context);
                          } else {
                            showCompleteSnackBar('บันทึกแก้ไขไม่สำเร็จ');
                          }
                        }
                      },
                      child: Text(
                        'บันทึกแก้ไขงาน Festival',
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
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (await FestApi().deleteFest(widget.fest!.festID!) ==
                            true) {
                          showCompleteSnackBar('ลบข้อมูลสำเร็จ');
                          Navigator.pop(context);
                        } else {
                          showWarningSnackBar('ลบข้อมูลไม่สำเร็จ');
                        }
                      },
                      child: Text(
                        'ลบงาน Festival',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
