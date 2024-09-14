import 'dart:convert';
import 'dart:developer';
import 'package:help_isko/models/data/announcement.dart';
import 'package:help_isko/models/data/prof_duty.dart';
import 'package:help_isko/services/global.dart';
import 'package:help_isko/services/storage.dart';
import 'package:http/http.dart' as http;

class AuthServices{
  final String apiUrl;

  AuthServices({required this.apiUrl});

  Future<Map<String, dynamic>> loginEmployee(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login-employee'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }

  Future<int> logout() async{
    final userData = await Storage.getData();
    String? token = userData['token'];
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      } 
    ); 
    // final Map<String, dynamic> responseData = jsonDecode(response.body);
    return response.statusCode;
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async{
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


   Future<Map<String, dynamic>> resetPassword(String email, String password, String confrimPassword, String token) async{
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

  Future<List<Announcement>> fetchAnnouncement() async{
    final userData = await Storage.getData();
    String? token = userData['token'];
    final response = await http.get(
      Uri.parse('$baseUrl/announcements'),
      headers: {
        'Content-Type': 'application/json',
         'Authorization': 'Bearer $token'
      },
    );
    if(response.statusCode == 200){
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> announcementList = jsonData['announcement'];
      return announcementList.map((json) => Announcement.fromJson(json)).toList();
    }else{
      log('The status code when fetching announcement is: ${response.statusCode}');
      throw Exception('Failed to load announcement');
    }
  }

  Future<List<ProfDuty>> fetchPostedDuties() async{
    final userData = await Storage.getData();
    String? token = userData['token'];
    final response = await http.get(
      Uri.parse('$baseUrl/professors/duties'),
      headers: {
        'Content-Type': 'application/json',
         'Authorization': 'Bearer $token'
      },
    );
    if(response.statusCode == 200){
      final List<dynamic> dutyList = json.decode(response.body);
      return dutyList.map((json) => ProfDuty.fromJson(json)).toList();
    }else{
      log('The status code is: ${response.statusCode}');
      throw Exception('Failed to load duties');
    }
  }
}