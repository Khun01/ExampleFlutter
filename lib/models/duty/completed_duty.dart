import 'package:help_isko/models/duty/students.dart';

class CompletedDuty {
  int? dutyId;
  String? building;
  String? startTime;
  String? endTime;
  String? date;
  int? fulfilled;
  Students? student; 

  CompletedDuty({
    this.dutyId,
    this.building,
    this.startTime,
    this.endTime,
    this.date,
    this.fulfilled,
    this.student,
  });

  factory CompletedDuty.fromJson(Map<String, dynamic> json) {
    var studentList =
        json['students'] as List<dynamic>?;
    Students? student = studentList != null && studentList.isNotEmpty
        ? Students.fromJson(studentList[0])
        : null;

    return CompletedDuty(
      dutyId: json['duty_id'] as int?,
      building: json['building'] as String? ?? '',
      startTime: json['start_time'] as String? ?? '',
      endTime: json['end_time'] as String? ?? '',
      date: json['date'] as String? ?? '',
      fulfilled: json['fulfilled'] ?? 0,
      student: student, // Use the parsed single student
    );
  }

  @override
  String toString() {
    return 'CompletedDuty(building: $building, start time: $startTime, end time: $endTime, date: $date, student: $student)';
  }
}
