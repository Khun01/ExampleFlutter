import 'package:help_isko/models/duty/request_for_duties_student.dart';

class RequestForDuties {
  final int dutyId;
  final String building;
  final String startTime;
  final String endTime;
  final String date;
  final String message;
  final int currentScholars;
  final int maxScholars;
  final int requestCount;
  RequestForDutiesStudent studentData;

  RequestForDuties({
    required this.dutyId,
    required this.building,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.message,
    required this.currentScholars,
    required this.maxScholars,
    required this.requestCount,
    required this.studentData,
  });

  factory RequestForDuties.fromJson(Map<String, dynamic> json) {
    return RequestForDuties(
      dutyId: json['duty_id'],
      building: json['building'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      date: json['date'],
      message: json['message'],
      currentScholars: json['current_scholars'],
      maxScholars: json['max_scholars'],
      requestCount: json['request_count'],
      studentData: RequestForDutiesStudent.fromJson(json['student_data'] as Map<String, dynamic>),
    );
  }

  String get formattedStartTime => _formatTime(startTime);
  String get formattedEndTime => _formatTime(endTime);

  String _formatTime(String time) {
    return time.substring(0, 5);
  }

}
