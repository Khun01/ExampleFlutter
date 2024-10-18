import 'package:help_isko/models/duty/students.dart';

class CompletedDuty {
  String? building;
  String? startTime;
  String? endTime;
  List<Students>? students;

  CompletedDuty({
    this.building,
    this.startTime,
    this.endTime,
    this.students,
  });

  factory CompletedDuty.fromJson(Map<String, dynamic> json) {
    var acceptedStudentsJson = json['students'] as List<dynamic>? ?? [];
    List<Students> studentsList = acceptedStudentsJson
        .map((studentJson) => Students.fromJson(studentJson))
        .toList();
    return CompletedDuty(
      building: json['building'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      students: studentsList,
    );
  }

  @override
  String toString() {
    return 'ProfDuty(building: $building, start time: $startTime, endTime: $endTime, $students: $students)';
  }
}
