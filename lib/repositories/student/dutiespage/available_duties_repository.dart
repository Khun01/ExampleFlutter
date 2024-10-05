import 'package:help_isko/models/student/available_duty.dart';
import 'package:help_isko/services/student/dutiespage/available_duties_service.dart';

class AvailableDutiesRepository {
  final AvailableDutiesService availableDutiesService;

  AvailableDutiesRepository(this.availableDutiesService);

  Future<List<AvailableDuty>> getAvailableDuties() async {
    try {
      return await availableDutiesService.getAvailableDuties();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> acceptDuty(int id) async {
    try {
      return await availableDutiesService.acceptDuty(id);
    } catch (e) {
      rethrow;
    }
  }
}
