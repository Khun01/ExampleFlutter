import 'package:help_isko/models/duty/prof_duty.dart';

class RecentActivities {
  final String title;
  final String description;
  final String message;
  final String date;
  final ProfDuty? duty;

  RecentActivities(
      {required this.title,
      required this.description,
      required this.message,
      required this.date,
      this.duty});

  factory RecentActivities.fromJson(Map<String, dynamic> json) {
    return RecentActivities(
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      message: json['message'] ?? 'No message',
      date: json['date'] ?? 'No date',
      duty: (json['duty'] != null && json['duty'] is List)
          ? ProfDuty.fromJson(json['duty'])
          : null,
    );
  }
}
