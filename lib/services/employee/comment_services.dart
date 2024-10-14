import 'dart:convert';
import 'dart:developer';

import 'package:help_isko/models/data/comment.dart';
import 'package:help_isko/models/data/rating.dart';
import 'package:help_isko/repositories/employee/comment_repository.dart';
import 'package:help_isko/repositories/storage/employee_storage.dart';
import 'package:http/http.dart' as http;

class CommentServices implements CommentRepository {
  final String baseUrl;

  CommentServices({required this.baseUrl});

  @override
  Future<Map<String, dynamic>> addComment(String comment, String studId) async {
    final userData = await EmployeeStorage.getData();
    String? token = userData['employeeToken'];
    var url = Uri.parse('$baseUrl/feedback/$studId/comment');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({"comment": comment}));
    return {'statusCode': response.statusCode, 'body': response.body};
  }

  @override
  Future<Map<String, dynamic>> addRatings(int ratings, String studId) async {
    final userData = await EmployeeStorage.getData();
    String? token = userData['employeeToken'];
    var url = Uri.parse('$baseUrl/feedback/$studId/rating');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({"rating": ratings}));
    return {'statusCode': response.statusCode, 'body': response.body};
  }

  @override
  Future<List<Comment>> fetchComment(String studentId) async {
    final userData = await EmployeeStorage.getData();
    String? token = userData['employeeToken'];
    final response = await http.get(
      Uri.parse('$baseUrl/feedback/index/$studentId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> commentList = jsonResponse['feedbacks'];
      return commentList.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load feedbacks');
    }
  }

  @override
  Future<Rating> fetchRating(String studentId) async {
    final userData = await EmployeeStorage.getData();
    String? token = userData['employeeToken'];
    final response = await http.get(
      Uri.parse('$baseUrl/feedback/show-rating/$studentId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final rating = Rating.fromJson(jsonDecode(response.body));
      log('Fetched Rating: $rating');
      return rating;
    } else {
      throw Exception('Failed to load feedbacks');
    }
  }
}
