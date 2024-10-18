import 'package:help_isko/models/duty/students.dart';

class CompletedDuty {
  int? dutyId;
  String? building;
  String? startTime;
  String? endTime;
  String? date;
  List<Students>? students;

  CompletedDuty({
    this.dutyId,
    this.building,
    this.startTime,
    this.endTime,
    this.date,
    this.students,
  });

  factory CompletedDuty.fromJson(Map<String, dynamic> json) {
    var studentList = json['students'] as List<dynamic>?;
    List<Students> studentsList = studentList != null 
        ? studentList.map((student) => Students.fromJson(student)).toList()
        : [];

    return CompletedDuty(
      dutyId: json['duty_id'] as int?,
      building: json['building'] as String? ?? '',  
      startTime: json['start_time'] as String? ?? '', 
      endTime: json['end_time'] as String? ?? '', 
      date: json['date'] as String? ?? '',
      students: studentsList,
    );
  }

  @override
  String toString() {
    return 'CompletedDuty(building: $building, start time: $startTime, endTime: $endTime, date: $date, Students: $students)';
  }
}
