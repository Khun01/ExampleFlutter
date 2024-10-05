import 'dart:convert';

import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/repositories/storage/student_storage.dart';
import 'package:http/http.dart';

class HkStatusService {
  Future<String> getHkStatus() async {
    try {
      final studentData = await StudentStorage.getData();

      final String token = studentData['studToken']!;

      final response = await get(Uri.parse('$baseUrl/hk-status'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final String percentage = jsonData['percentage'];
        return percentage;
      } else {
        throw Exception('No Duty Hours');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
