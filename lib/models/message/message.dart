import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  int id;
  String message;
  int sender_id;
  int receiver_id;
  Message({
    required this.id,
    required this.message,
    required this.sender_id,
    required this.receiver_id,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as int,
      message: map['message'] as String,
      sender_id: map['sender_id'] as int,
      receiver_id: map['receiver_id'] as int,
    );
  }
 
}
