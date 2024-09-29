import 'package:help_isko/models/duty/request_for_duties.dart';

abstract class RequestForDutyRepository {
  Future<List<RequestForDuties>> fetchRequestForDuties();
  Future<Map<String, dynamic>> acceptStudent(int dutyId, int studentId);
  Future<Map<String, dynamic>> declineStudent(int dutyId, int studentId);
}