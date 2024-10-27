import 'package:help_isko/models/employee/comment.dart';
import 'package:help_isko/models/employee/rating.dart';

abstract class CommentRepository {
  Future<List<Comment>> fetchComment(String studentId);
  Future<Rating> fetchRating(String studentId);
  Future<Map<String, dynamic>> addComment(String comment, String studId);
  Future<Map<String, dynamic>> addRatings(int ratings, String studId);
}