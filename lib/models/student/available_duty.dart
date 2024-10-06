// ignore_for_file: public_member_api_docs, sort_constructors_first

class AvailableDuty {
  final int id;
  final String building;
  final String date;
  final String startTime;
  final String endTime;
  final int duration;
  final String message;
  final int maxScholars;
  final int currentScholars;
  final String employeeName;
  final String? employeeProfile;

  AvailableDuty(
      {required this.id,
      required this.building,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.duration,
      required this.message,
      required this.maxScholars,
      required this.currentScholars,
      required this.employeeName,
      this.employeeProfile});

  factory AvailableDuty.fromMap(Map<String, dynamic> map) {
    return AvailableDuty(
      id: map['id'] as int,
      building: map['building'] as String,
      date: map['date'] as String,
      startTime: map['start_time'] as String,
      endTime: map['end_time'] as String,
      duration: map['duration'] as int,
      message: map['message'] as String,
      maxScholars: map['max_scholars'] as int,
      currentScholars: map['current_scholars'] as int,
      employeeName: map['employee_name'] as String,
      employeeProfile: map['employe_profile'] as String,
    );
  }
}
