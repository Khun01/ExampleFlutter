// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:help_isko/models/message/message.dart';
import 'package:help_isko/models/message/user.dart';

class ExistingChat {
  User user;
  Message message;
  ExistingChat({
    required this.user,
    required this.message,
  });

  factory ExistingChat.fromMap(Map<String, dynamic> map) {
    return ExistingChat(
      user: User.fromMap(map['user_profile'] as Map<String, dynamic>),
      message: Message.fromMap(map['latest_message'] as Map<String, dynamic>),
    );
  }
}
