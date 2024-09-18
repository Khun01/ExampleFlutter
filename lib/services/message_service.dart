import 'dart:convert';
import 'dart:math';

import 'package:help_isko/models/message/existing_chat.dart';
import 'package:help_isko/models/message/user.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/repositories/storage/employee_storage.dart';
import 'package:help_isko/repositories/storage/student_storage.dart';
import 'package:http/http.dart';

class MessageService {
  String role;

  MessageService({required this.role});

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

        final List<ExistingChat> existingChats = existingChatsJson.map((e) => ExistingChat.fromMap(e)).toList();
        return existingChats;
      } else {
        throw Exception('status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
