import 'dart:convert';
import 'dart:developer';

import 'package:help_isko/models/duty/request_for_duties.dart';
import 'package:help_isko/repositories/duty/request_for_duty_repository.dart';
import 'package:help_isko/repositories/storage/employee_storage.dart';
import 'package:http/http.dart' as http;

class RequestForDutiesServices implements RequestForDutyRepository {
  final String baseUrl;

  RequestForDutiesServices({required this.baseUrl});

  @override
  Future<List<RequestForDuties>> fetchRequestForDuties() async {
    final userData = await EmployeeStorage.getData();
    String? token = userData['employeeToken'];
    final response = await http.get(
      Uri.parse('$baseUrl/employees/duties/requests/student'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> dutyList = json.decode(response.body);
      return dutyList.map((json) => RequestForDuties.fromJson(json)).toList();
    } else {
      log('The status code in request for duty is: ${response.statusCode}');
      throw Exception('Failed to load duties');
    }
  }

  @override
  Future<Map<String, dynamic>> acceptStudent(int dutyId, int studentId) async {
    final userData = await EmployeeStorage.getData();
    String? token = userData['employeeToken'];
    final url = Uri.parse('$baseUrl/employees/requests/accept');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({'duty_id': dutyId, 'stud_id': studentId}));
    return {'statusCode': response.statusCode};
  }

  @override
  Future<Map<String, dynamic>> declineStudent(int dutyId, int studentId) async {
    final userData = await EmployeeStorage.getData();
    String? token = userData['employeeToken'];
    final url = Uri.parse('$baseUrl/employees/requests/reject');
    final response = await http.delete(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({'duty_id': dutyId, 'stud_id': studentId}));
    return {'statusCode': response.statusCode};
  }
}
