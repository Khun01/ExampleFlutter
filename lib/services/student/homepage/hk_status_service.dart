import 'dart:convert';
import 'dart:developer';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/repositories/storage/student_storage.dart';
import 'package:http/http.dart';

class HkStatusService {
  Future<double> getHkStatus() async {
    try {
      final studentData = await StudentStorage.getData();

      final String token = studentData['studToken']!;

      final response = await get(Uri.parse('$baseUrl/hk-status'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final percentage = jsonData['percentage'];
        double newPercentage;
        if (percentage is int) {
          newPercentage = percentage / 100;
        } else if (percentage is double) {
          newPercentage = percentage / 100;
        } else {
          throw Exception('Invalid data type for percentage');
        }
        log('The new percentage is: $newPercentage');
        return newPercentage;
      } else {
        throw Exception('No Duty Hours');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
