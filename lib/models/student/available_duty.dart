// ignore_for_file: public_member_api_docs, sort_constructors_first

class AvailableDuty {
  final int id;
  final String building;
  final String date;
  final String startTime;
  final String endTime;
  final int duration;
  final String message;
  final String? dutyStatus;
  final int maxScholars;
  final int currentScholars;
  final String employeeName;
  final String? employeeProfile;
  final String? employeeNumber;

  AvailableDuty({
    required this.id,
    required this.building,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.message,
    this.dutyStatus,
    required this.maxScholars,
    required this.currentScholars,
    required this.employeeName,
    this.employeeProfile,
    this.employeeNumber,
  });

  factory AvailableDuty.fromMap(Map<String, dynamic> map) {
    return AvailableDuty(
      id: map['id'] as int,
      building: map['building'] as String,
      date: map['date'] as String,
      startTime: map['start_time'] as String,
      endTime: map['end_time'] as String,
      duration: map['duration'] as int,
      message: map['message'] as String,
      dutyStatus: map['duty_status'],
      maxScholars: map['max_scholars'] as int,
      currentScholars: map['current_scholars'] as int,
      employeeName: map['employee_name'] as String,
      employeeProfile: map['employe_profile'],
      employeeNumber: map['employee_number'],
    );
  }
}
