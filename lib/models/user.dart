class User {
  int? userID;
  String? userFullName;
  String? userName;
  String? userPassword;
  String? userImage;

  //เอาไว้แพ็คข้อมูล User
  User(
      {this.userID,
      this.userFullName,
      this.userName,
      this.userPassword,
      this.userImage});

  //เอาไว้แปลง Json Data ให้เป็นข้อมูลที่ใช้ใน App
  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    userFullName = json['userFullName'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userImage = json['userImage'];
  }

  //เอาไว้แปลงข้อมูลที่ใช้ใน App ไปเป็น Json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['userFullName'] = userFullName;
    data['userName'] = userName;
    data['userPassword'] = userPassword;
    data['userImage'] = userImage;
    return data;
  }
}
