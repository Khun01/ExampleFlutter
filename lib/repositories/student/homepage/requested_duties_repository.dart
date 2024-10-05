import 'package:help_isko/models/student/requested_duties.dart';
import 'package:help_isko/services/student/homepage/requested_duties_service.dart';

class RequestedDutiesRepository {
  final RequestedDutiesService requestedDutiesService;

  const RequestedDutiesRepository({required this.requestedDutiesService});

  Future<List<RequestedDuties>> getRequestedDuties() async {
    try {
      final requestedDuties = await requestedDutiesService.getRequestedDuties();
      return requestedDuties;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> cancelRequestedDuties({required int id}) async {
    try {
      final status = await requestedDutiesService.cancelRequestedDuties(id: id);
      return status;
    } catch (e) {
      rethrow;
    }
  }
}
