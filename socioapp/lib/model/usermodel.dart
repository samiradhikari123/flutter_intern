import 'dart:io';

class Usermodel {
  File profilepic;
  File coverpic;
  String? userid;
  String? fullname;
  String? email;
  String? password;
  String? mobilenumber;
  String? dateofbirth;
  String? gender;
  String? maritalstatus;

  Usermodel({
    required this.profilepic,
    required this.coverpic,
    this.userid,
    this.fullname,
    this.email,
    this.password,
    this.mobilenumber,
    this.dateofbirth,
    this.gender,
    this.maritalstatus,
  });
  Map<String, dynamic> toJson() {
    String profilepicPath = profilepic.path;
    String coverpicPath = coverpic.path;

    return {
      'profilepic': profilepicPath,
      'coverpic': coverpicPath,
      'userid': userid,
      'fullname': fullname,
      'email': email,
      'password': password,
      'mobilenumber': mobilenumber,
      'dateofbirth': dateofbirth,
      'gender': gender,
      'maritalstatus': maritalstatus,
    };
  }

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    String imagepath = json["profilepic"] ?? "";
    String coverpath = json["coverpic"] ?? "";

    return Usermodel(
        profilepic: File(imagepath),
        coverpic: File(coverpath),
        userid: json['userid'],
        fullname: json['fullname'],
        email: json['email'],
        password: json['password'],
        mobilenumber: json['mobilenumber'],
        dateofbirth: json['dateofbirth'],
        gender: json['gender'],
        maritalstatus: json['maritalstatus']);
  }
}

List<Usermodel> signuplist = [];
