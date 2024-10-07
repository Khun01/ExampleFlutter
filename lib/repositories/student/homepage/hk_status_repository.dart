import 'package:help_isko/services/student/homepage/hk_status_service.dart';

class HkStatusRepository {
  final HkStatusService hkStatusService;

  HkStatusRepository({required this.hkStatusService});

  Future<double> getHkStatus() async {
    try {
      final percentage = await hkStatusService.getHkStatus();

      return percentage;
    } catch (e) {
      rethrow;
    }
  }
}
