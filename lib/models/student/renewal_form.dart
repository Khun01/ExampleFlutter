class RenewalForm {
  final String studentNumber;
  final int attendedEvents;
  final int sharedPosts;
  final String registrationFeePicture; 
  final String disbursementMethod;
  final int dutyHours;

  RenewalForm({
    required this.studentNumber,
    required this.attendedEvents,
    required this.sharedPosts,
    required this.registrationFeePicture,
    required this.disbursementMethod,
    required this.dutyHours,
  });

  // Factory constructor to create an instance from JSON
  factory RenewalForm.fromJson(Map<String, dynamic> json) {
    return RenewalForm(
      studentNumber: json['student_number'],
      attendedEvents: json['attended_events'],
      sharedPosts: json['shared_posts'],
      registrationFeePicture: json['registration_fee_picture'],
      disbursementMethod: json['disbursement_method'],
      dutyHours: json['duty_hours'],
    );
  }
}
