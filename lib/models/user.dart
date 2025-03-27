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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['userFullName'] = this.userFullName;
    data['userName'] = this.userName;
    data['userPassword'] = this.userPassword;
    data['userImage'] = this.userImage;
    return data;
  }
}
