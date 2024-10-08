import 'package:help_isko/models/duty/prof_duty.dart';

abstract class DutyRepository {
  Future<List<ProfDuty>> fetchPostedDuties();
  Future<Map<String, dynamic>> addDuty(String building, String date, String startTime, String endTime, String maxScholars, String message);
  Future<Map<String, dynamic>> updateDuty(int id, ProfDuty profDuty);
  Future<Map<String, dynamic>> deleteDuty(int id);
}
