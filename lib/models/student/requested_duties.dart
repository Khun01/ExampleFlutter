// ignore_for_file: public_member_api_docs, sort_constructors_first
class RequestedDuties {
  final int id;
  final String employeeName;
  final String message;
  final String date;
  final String building;
  final String time;
  final int maxScholars;
  final String dutyStatus;
  final String requestStatus;
  final String? employeeProfile;
  final String? employeeNumber;
  const RequestedDuties({
    required this.id,
    required this.employeeName,
    required this.message,
    required this.date,
    required this.building,
    required this.time,
    required this.maxScholars,
    required this.dutyStatus,
    required this.requestStatus,
    this.employeeProfile,
    this.employeeNumber,
  });

  factory RequestedDuties.fromMap(Map<String, dynamic> map) {
    return RequestedDuties(
      id: map['id'] as int,
      employeeName: map['employee_name'] as String,
      message: map['message'] as String,
      date: map['date'] as String,
      building: map['building'] as String,
      time: map['time'] as String,
      maxScholars: map['max_scholars'] as int,
      dutyStatus: map['duty_status'] as String,
      requestStatus: map['request_status'],
      employeeProfile: map['employee_profile']['profile_img'] as String?,
      employeeNumber: map['employee_profile']['employee_number'] as String?
    );
  }
}
