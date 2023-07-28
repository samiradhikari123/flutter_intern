class WorkExpField {
  String jobTitle;
  String summary;
  String companyName;
  String startdate;
  String enddate;
  WorkExpField({
    required this.jobTitle,
    required this.summary,
    required this.companyName,
    required this.startdate,
    required this.enddate,
  });
  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'summary': summary,
      'companyName': companyName,
      'startdate': startdate,
      'enddate': enddate,
    };
  }

  factory WorkExpField.fromJson(Map<String, dynamic> json) {
    return WorkExpField(
        jobTitle: json['jobTitle'],
        summary: json['summary'],
        companyName: json['companyName'],
        startdate: json['startdate'],
        enddate: json['enddate']);
  }
}

List<WorkExpField> workFieldsList = [];
