class Students {
  int studentId;
  String? profile;
  String? name;
  String? email;
  String? studentNumber;
  String? contactNumber;
  String? course;
  String? semester;
  String? status;

  Students(
      {required this.studentId,
      required this.profile,
      required this.name,
      required this.email,
      required this.studentNumber,
      required this.contactNumber,
      required this.course,
      required this.semester,
      this.status});

  factory Students.fromJson(Map<String, dynamic> json) {
    return Students(
        studentId: json['student_id'],
        profile: json['profile_image'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        studentNumber: json['student_number'] ?? '',
        contactNumber: json['contact_number'] ?? '',
        course: json['course'] ?? '',
        semester: json['semester'] ?? '',
        status: json['request_status'] ?? '');
  }
}
