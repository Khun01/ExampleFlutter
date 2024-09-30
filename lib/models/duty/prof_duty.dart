import 'package:help_isko/models/duty/students.dart';

class ProfDuty {
  final int? id;
  final String? building;
  final String? date;
  final String? startTime;
  final String? endTime;
  final int? duration;
  final String? message;
  final int? maxScholars;
  final int? currentScholars;
  final int? isLocked;
  final String? dutyStatus;
  final int? isCompleted;
  final int? profId;
  final List<Students>? students;

  ProfDuty(
      {this.id,
       this.building,
       this.date,
       this.startTime,
       this.endTime,
       this.duration,
       this.message,
       this.maxScholars,
       this.currentScholars,
       this.isLocked,
       this.dutyStatus,
       this.isCompleted,
       this.profId,
       this.students});

  factory ProfDuty.fromJson(Map<String, dynamic> json) {
    var acceptedStudentsJson = json['accepted_students'] as List;
    List<Students> studentsList =
        acceptedStudentsJson.map((studentJson) => Students.fromJson(studentJson)).toList();

    return ProfDuty(
      id: json['duty']['id'],
      building: json['duty']['building'],
      date: json['duty']['date'],
      startTime: json['duty']['start_time'],
      endTime: json['duty']['end_time'],
      duration: json['duty']['duration'],
      message: json['duty']['message'],
      maxScholars: json['duty']['max_scholars'],
      currentScholars: json['duty']['current_scholars'],
      isLocked: json['duty']['is_locked'],
      dutyStatus: json['duty']['duty_status'],
      isCompleted: json['duty']['is_completed'],
      students: studentsList,
    );
  }

  String get formattedStartTime => _formatTime(startTime!);
  String get formattedEndTime => _formatTime(endTime!);

  String _formatTime(String time) {
    return time.substring(0, 5);
  }
}
