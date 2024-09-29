class RequestForDutiesStudent {
  int studentId;
  String? profile;
  String name;

  RequestForDutiesStudent({
    required this.studentId,
    required this.profile,
    required this.name,
  });

  factory RequestForDutiesStudent.fromJson(Map<String, dynamic> json) {
    return RequestForDutiesStudent(
      studentId: json['student_id'],
      profile: json['profile_image'] ?? '',
      name: json['name'],
    );
  }
}
