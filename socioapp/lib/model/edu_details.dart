class Edudetails {
  String organizationName;
  String startdate;
  String enddate;
  String achievements;
  String level;
  Edudetails({
    required this.level,
    required this.organizationName,
    required this.startdate,
    required this.enddate,
    required this.achievements,
  });
  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'organizationName': organizationName,
      'startdate': startdate,
      'enddate': enddate,
      'achievements': achievements,
    };
  }

  factory Edudetails.fromJson(Map<String, dynamic> json) {
    return Edudetails(
        level: json['level'],
        organizationName: json['organizationName'],
        startdate: json['startdate'],
        enddate: json['enddate'],
        achievements: json['achievements']);
  }
}

List<Edudetails> eduFieldsList = [];
