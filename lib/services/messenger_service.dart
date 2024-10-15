import 'dart:convert';
import 'package:help_isko/models/message/existing_chat.dart';
import 'package:help_isko/models/message/message.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/repositories/storage/employee_storage.dart';
import 'package:help_isko/repositories/storage/student_storage.dart';
import 'package:http/http.dart';

class MessengerService {
  String role;

  MessengerService({required this.role});

  Future<String> getToken() async {
    if (role == 'Employee') {
      final data = await EmployeeStorage.getData();
      return data['employeeToken']!;
    } else {
      final data = await StudentStorage.getData();
      return data['studToken']!;
    }
  }

  Future<List<ExistingChat>> getExistingChats(String token) async {
    try {
      final response = await get(Uri.parse('$baseUrl/existing-chat-users'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> existingChatsJson = json['messages'];

        final List<ExistingChat> existingChats =
            existingChatsJson.map((e) => ExistingChat.fromMap(e)).toList();
        return existingChats;
      } else {
        throw Exception('status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<List<Message>> getChats(String token, int targetUserId) async {
    try {
      final response = await get(
          Uri.parse('$baseUrl/view-messages/$targetUserId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });

      if (response.statusCode == 200) {
        final List jsonChats = jsonDecode(response.body);

        final List<Message> chats =
            jsonChats.map((e) => Message.fromMap(e)).toList();
        print('$baseUrl/view-messages/$targetUserId');

        return chats;
      } else {
        print(response.statusCode);
        throw Exception('Cant Get Chats');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<Message> sendMessage(
      String token, int targetUserId, String message) async {
    try {
      final response = await post(
        Uri.parse('$baseUrl/send-message/$targetUserId'),
        body: {'message': message},
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMessage = jsonDecode(response.body);
        final Message message = Message.fromMap(jsonMessage);

        return message;
      } else {
        throw Exception('Cant send Message');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
