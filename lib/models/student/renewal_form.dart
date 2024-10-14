class RenewalForm {
  final int? id;
  final String studentNumber;
  final int attendedEvents;
  final int sharedPosts;
  final String registrationFeePicture; 
  final String disbursementMethod;
  final int dutyHours;
  final String approvalStatus;

  RenewalForm({
    this.id,
    required this.studentNumber,
    required this.attendedEvents,
    required this.sharedPosts,
    required this.registrationFeePicture,
    required this.disbursementMethod,
    required this.dutyHours,
    this.approvalStatus = 'pending',
  });

  // Factory constructor to create an instance from JSON
  factory RenewalForm.fromJson(Map<String, dynamic> json) {
    return RenewalForm(
      id: json['id'],
      studentNumber: json['student_number'],
      attendedEvents: json['attended_events'],
      sharedPosts: json['shared_posts'],
      registrationFeePicture: json['registration_fee_picture'],
      disbursementMethod: json['disbursement_method'],
      dutyHours: json['duty_hours'],
      approvalStatus: json['approval_status'],
    );
  }

  // To JSON function for sending data to the API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_number': studentNumber,
      'attended_events': attendedEvents,
      'shared_posts': sharedPosts,
      'registration_fee_picture': registrationFeePicture,
      'disbursement_method': disbursementMethod,
      'duty_hours': dutyHours,
      'approval_status': approvalStatus,
    };
  }
}
