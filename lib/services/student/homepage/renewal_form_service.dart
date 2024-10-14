import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:help_isko/repositories/storage/student_storage.dart';
import 'package:help_isko/models/student/renewal_form.dart';

class RenewalFormService {
  final String baseUrl;

  RenewalFormService({required this.baseUrl});

  Future<RenewalForm> submitRenewalForm(
      {String? studentNumber,
      int? attendedEvents,
      int? sharedPosts,
      int? dutyHours,
      String? registrationFeePic}) async {
    try {
      final studentData = await StudentStorage.getData();
      final String token = studentData['studToken']!;
      var uri = Uri.parse('$baseUrl/student/renewal-form');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "student_number": studentNumber,
          'attended_events': attendedEvents,
          'shared_posts': sharedPosts,
          'duty_hours': dutyHours,
          'registration_fee_picture': registrationFeePic,
        }),
      );
      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        log('Form submitted successfully: $json');
        return RenewalForm.fromJson(json['renewal_form']);
      } else {
        final json = jsonDecode(response.body);
        final errorMessage = json['message'] ?? 'Unknown error';
        log('Failed with status code: ${response.statusCode}');
        throw (errorMessage);
      }
    } catch (e) {
      log('Error occurred: $e');
      throw e.toString();
    }
  }
}
