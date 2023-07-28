class OtherProjField {
  String projectTitle;
  String description;
  String startdate;
  String enddate;
  String organizationName;
  OtherProjField({
    required this.projectTitle,
    required this.description,
    required this.enddate,
    required this.startdate,
    required this.organizationName,
  });
  Map<String, dynamic> toJson() {
    return {
      'projectTitle': projectTitle,
      'description': description,
      'enddate': enddate,
      'startdate': startdate,
      'organizationName': organizationName,
    };
  }

  factory OtherProjField.fromJson(Map<String, dynamic> json) {
    return OtherProjField(
        projectTitle: json['projectTitle'],
        description: json['description'],
        enddate: json['enddate'],
        startdate: json['startdate'],
        organizationName: json['organizationName']);
  }
}

List<OtherProjField> projFieldsList = [];
