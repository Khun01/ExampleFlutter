class RequestForDutiesStudent {
  int studentId;
  String? profile;
  String name;
  String email;
  String studentNumber;
  String contactNumber;
  String course;
  String semester;

  RequestForDutiesStudent({
    required this.studentId,
    required this.profile,
    required this.name,
    required this.email,
    required this.studentNumber,
    required this.contactNumber,
    required this.course,
    required this.semester
  });

  factory RequestForDutiesStudent.fromJson(Map<String, dynamic> json) {
    return RequestForDutiesStudent(
      studentId: json['student_id'],
      profile: json['profile_image'] ?? '',
      name: json['name'],
      email: json['email'],
      studentNumber: json['student_number'],
      contactNumber: json['contact_number'],
      course: json['course'],
      semester: json['semester']
    );
  }
}
