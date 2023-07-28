import 'package:intern1/edudetails.dart';
import 'package:intern1/otprojfield.dart';
import 'package:intern1/workexp_field.dart';

class Cvdisplay {
  final String firstname;
  final String middleName;
  final String lastname;
  final String age;
  final String gender;
  final List<String> skills;
  final List<WorkExpField> workExperience;
  final List<Edudetails> educationDetails;
  final List<OtherProjField> otherProjects;
  final List<String> language;
  final List<String> interestArea;
  Cvdisplay({
    required this.firstname,
    required this.middleName,
    required this.lastname,
    required this.age,
    required this.gender,
    required this.skills,
    required this.workExperience,
    required this.educationDetails,
    required this.otherProjects,
    required this.language,
    required this.interestArea,
  });
  factory Cvdisplay.fromJson(Map<String, dynamic> json) {
    return Cvdisplay(
        firstname: json['firstname'],
        middleName: json['middleName'],
        lastname: json['lastname'],
        age: json['age'],
        gender: json['gender'],
        skills: List<String>.from(json['skills']),
        workExperience: List<WorkExpField>.from(
            json['workExperience'].map((e) => WorkExpField.fromJson(e))),
        educationDetails: List<Edudetails>.from(
            json['educationDetails'].map((e) => Edudetails.fromJson(e))),
        otherProjects: List<OtherProjField>.from(
            json['otherProjects'].map((e) => OtherProjField.fromJson(e))),
        language: List<String>.from(json['language']),
        interestArea: List<String>.from(json['interestArea']));
  }
  Map<String, dynamic> tojson() {
    return {
      'firstname': firstname,
      'middleName': middleName,
      'lastname': lastname,
      'age': age,
      'gender': gender,
      'skills': skills,
      'workExperience': workExperience.map((e) => e.toJson()).toList(),
      'educationDetails': educationDetails.map((e) => e.toJson()).toList(),
      'otherProjects': otherProjects.map((e) => e.toJson()).toList(),
      'language': language,
      'interestArea': interestArea,
    };
  }
}

List<Cvdisplay> cvFieldsLists = [];
