class AttendanceModel {
  final String subjectID;
  final num percentage;

  AttendanceModel({required this.subjectID, required this.percentage});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      subjectID: json['Subject_ID'],
      percentage: json['Percentage'],
    );
  }
}
