import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/repositories/storage/student_storage.dart';
import 'package:help_isko/models/student/renewal_form.dart';
import 'dart:io';

class RenewalFormService {
  Future<RenewalForm> submitRenewalForm({
    required String studentNumber,
    required int attendedEvents,
    required int sharedPosts,
    required File? registrationFeePicture, // File for picture
    required File? disbursementMethod, // File for picture
    required int dutyHours,
  }) async {
    try {
      final studentData = await StudentStorage.getData();
      final String token = studentData['studToken']!;

      // Prepare the multipart request
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/student/renewal-form'));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Add the form fields
      request.fields['student_number'] = studentNumber;
      request.fields['attended_events'] = attendedEvents.toString();
      request.fields['shared_posts'] = sharedPosts.toString();
      request.fields['duty_hours'] = dutyHours.toString();

      // Add the images if they are provided
      if (registrationFeePicture != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'registration_fee_picture',
          registrationFeePicture.path,
        ));
      }

      if (disbursementMethod != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'disbursement_method',
          disbursementMethod.path,
        ));
      }

      // Send the request and get the response
      final response = await request.send();

      // Log the response for debugging
      if (response.statusCode == 201) {
        final resBody = await response.stream.bytesToString();
        final json = jsonDecode(resBody);
        print('Form submitted successfully: $json');
        return RenewalForm.fromJson(json['renewal_form']);
      } else {
        final resBody = await response.stream.bytesToString();
        print('Failed with status code: ${response.statusCode}');
        print('Response body: $resBody');
        throw Exception('Failed to submit renewal form');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error occurred: $e');
      throw Exception('Error: $e');
    }
  }

  // New method to fetch a specific renewal form by ID
  Future<RenewalForm> getRenewalFormById(String formId) async {
    try {
      final studentData = await StudentStorage.getData();
      final String token = studentData['studToken']!;

      // Fetch the renewal form by ID
      final url = Uri.parse('$baseUrl/student/renewal-form/$formId');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Fetched form successfully: $jsonResponse');
        return RenewalForm.fromJson(jsonResponse['renewal_form']);
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch renewal form');
      }
    } catch (e) {
      // Handle errors during fetch
      print('Error occurred: $e');
      throw Exception('Error: $e');
    }
  }
}
