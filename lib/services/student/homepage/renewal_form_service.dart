import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:help_isko/repositories/storage/student_storage.dart';

class RenewalFormService {
  final String baseUrl;

  RenewalFormService({required this.baseUrl});

  Future<Map<String, dynamic>> submitRenewalForm({
    required String studentNumber,
    required int attendedEvents,
    required int sharedPosts,
    required int dutyHours,
    String? registrationFeePic,
  }) async {
    try {
      final studentData = await StudentStorage.getData();
      final String token = studentData['studToken']!;
      var uri = Uri.parse('$baseUrl/student/renewal-form');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "student_number": studentNumber,
          'attended_events': attendedEvents,
          'shared_posts': sharedPosts,
          'duty_hours': dutyHours,
          'registration_fee_picture': registrationFeePic,
        }),
      );
      return {'statusCode': response.statusCode, 'body': response.body};
    } catch (e) {
      log('Error occurred: $e');
      throw Exception('Failed to submit renewal form: $e');
    }
  }
}
