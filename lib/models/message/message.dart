import 'package:intl/intl.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  int id;
  String message;
  int sender_id;
  int receiver_id;
  String created_at;
  Message({
    required this.id,
    required this.message,
    required this.sender_id,
    required this.receiver_id,
    required this.created_at,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    final dateTimeString = map['created_at'] as String;
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    return Message(
      id: map['id'] as int,
      message: map['message'] as String,
      sender_id: map['sender_id'] as int,
      receiver_id: map['receiver_id'] as int,
      created_at: formattedTime,
    );
  }
}
