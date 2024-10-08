import 'dart:convert';
import 'dart:developer';
import 'package:help_isko/models/data/announcement.dart';
import 'package:help_isko/models/duty/students.dart';
import 'package:help_isko/repositories/pusher_repository.dart';
import 'package:help_isko/repositories/storage/employee_storage.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/repositories/storage/student_storage.dart';
import 'package:http/http.dart' as http;

class ApiRepositories {
  final String apiUrl;
  final PusherRepository _pusher = PusherRepository();

  ApiRepositories({required this.apiUrl});

  Future<Map<String, dynamic>> loginEmployee(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login-employee'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    _pusher.pusherConnect();
    _pusher.subscribeChannel(responseData['user']['user_id']);

    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }

  Future<Map<String, dynamic>> loginStud(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login-stud'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    _pusher.pusherConnect();
    _pusher.subscribeChannel(responseData['user']['user_id']);
    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }

  Future<int> logout(String role) async {
    try {
      String? token;
      String? id;

      if (role == 'Employee') {
        final userDataEmployee = await EmployeeStorage.getData();
        token = userDataEmployee['employeeToken'];
        id = userDataEmployee['user_id'];
        _pusher.disconnect(int.parse(id!));
      } else if (role == 'Student') {
        final userDataStudent = await StudentStorage.getData();
        token = userDataStudent['studToken'];
        id = userDataStudent['user_id'];
        _pusher.disconnect(int.parse(id!));
      }

      if (token == null) {
        throw Exception('Token is null for role: $role');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return response.statusCode;
    } catch (e) {
      log('Error during logout: $e');
      return 500;
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forgot'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    log('The response is: $response');
    log('The response is: $responseData');
    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }

  Future<Map<String, dynamic>> resetPassword(String email, String password,
      String confrimPassword, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/reset'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'password_confirmation': confrimPassword,
        'token': token,
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    log('The response is: $response');
    log('The response is: $responseData');
    log('The response is: ${response.statusCode}');
    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }

  Future<List<Announcement>> fetchAnnouncement(String role) async {
    final userDataStudent = await StudentStorage.getData();
    final userDataEmployee = await EmployeeStorage.getData();
    String? tokenEmployee = userDataEmployee['employeeToken'];
    String? tokenStudent = userDataStudent['studToken'];
    final response = await http.get(
      Uri.parse('$baseUrl/announcements'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${role == 'Employee' ? tokenEmployee : tokenStudent}'
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> announcementList = jsonData['announcement'];
      return announcementList
          .map((json) => Announcement.fromJson(json))
          .toList();
    } else {
      log('The status code when fetching announcement is: ${response.statusCode}');
      throw Exception('Failed to load announcement');
    }
  }

  Future<List<Students>> fetchAllStudents() async {
    final userData = await EmployeeStorage.getData();
    String? token = userData['employeeToken'];
    final response = await http.get(
      Uri.parse('$baseUrl/retrieve/students'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> studentList = json.decode(response.body);
      return studentList.map((json) => Students.fromJson(json)).toList();
    } else {
      log('The status code is: ${response.statusCode}');
      throw Exception('Failed to load duties');
    }
  }
  
}
