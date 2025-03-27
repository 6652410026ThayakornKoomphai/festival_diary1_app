class Fest {
  int? festID;
  String? festName;
  String? festDetail;
  String? festState;
  int? festNumDay;
  String? festCost;
  int? userID;
  String? festImage;

  Fest(
      {this.festID,
      this.festName,
      this.festDetail,
      this.festState,
      this.festNumDay,
      this.festCost,
      this.userID,
      this.festImage});

  Fest.fromJson(Map<String, dynamic> json) {
    festID = json['festID'];
    festName = json['festName'];
    festDetail = json['festDetail'];
    festState = json['festState'];
    festNumDay = json['festNumDay'];
    festCost = json['festCost'];
    userID = json['userID'];
    festImage = json['festImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['festID'] = festID;
    data['festName'] = festName;
    data['festDetail'] = festDetail;
    data['festState'] = festState;
    data['festNumDay'] = festNumDay;
    data['festCost'] = festCost;
    data['userID'] = userID;
    data['festImage'] = festImage;
    return data;
  }
}
