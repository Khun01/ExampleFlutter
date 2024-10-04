class Notification {
  final String title;
  final String message;
  final String date;

  Notification(
      {required this.title, required this.message, required this.date});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
        title: json['title'], message: json['message'], date: json['date']);
  }
}
