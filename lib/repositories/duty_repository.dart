import 'package:help_isko/models/data/prof_duty.dart';

abstract class DutyRepository {
  Future<List<ProfDuty>> fetchPostedDuties();
  Future<Map<String, dynamic>> addDuty(ProfDuty profDuty);
  Future<Map<String, dynamic>> updateDuty(int id, ProfDuty profDuty);
  Future<Map<String, dynamic>> deleteDuty(int id);
}
