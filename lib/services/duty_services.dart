import 'dart:convert';
import 'dart:developer';

import 'package:help_isko/models/data/prof_duty.dart';
import 'package:help_isko/repositories/duty_repository.dart';
import 'package:help_isko/repositories/storage/employee_storage.dart';
import 'package:http/http.dart' as http;

class DutyServices implements DutyRepository {
  final String baseUrl;

  DutyServices({required this.baseUrl});

  @override
  Future<List<ProfDuty>> fetchPostedDuties() async {
    final userData = await EmployeeStorage.getData();
    String? token = userData['employeeToken'];
    final response = await http.get(
      Uri.parse('$baseUrl/employees/duty'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200 || response.statusCode == 404) {
      final List<dynamic> dutyList = json.decode(response.body);
      return dutyList.map((json) => ProfDuty.fromJson(json)).toList();
    } else {
      log('The status code is: ${response.statusCode}');
      throw Exception('Failed to load duties');
    }
  }

  @override
  Future<Map<String, dynamic>> addDuty(ProfDuty profDuty) async {
    final userData = await EmployeeStorage.getData();
    String? token = userData['employeeToken'];
    var url = Uri.parse('$baseUrl/employees/duties/create');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'building': profDuty.building,
          'date': profDuty.date,
          'start_time': profDuty.startTime,
          'end_time': profDuty.endTime,
          'max_scholars': profDuty.maxScholars,
          'message': profDuty.message
        }));
    return {'statusCode': response.statusCode};
  }

  @override
  Future<Map<String, dynamic>> updateDuty(int id, ProfDuty profDuty) async {
    final userData = await EmployeeStorage.getData();
    String? token = userData['employeeToken'];
    var url = Uri.parse('$baseUrl/employees/updateInfo/$id');
    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'building': profDuty.building,
          'date': profDuty.date,
          'start_time': profDuty.startTime,
          'end_time': profDuty.endTime,
          'message': profDuty.message,
          'max_scholars': profDuty.maxScholars
        }));
    return {
      'statusCode': response.statusCode,
      'body': response.body,
      'headers': response.headers,
    };
  }

  @override
  Future<Map<String, dynamic>> deleteDuty(int id) async {
    final userData = await EmployeeStorage.getData();
    String? token = userData['employeeToken'];
    var url = Uri.parse('$baseUrl/employees/duties/$id');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return {
      'statusCode': response.statusCode,
      'body': response.body,
      'headers': response.headers,
    };
  }
}
