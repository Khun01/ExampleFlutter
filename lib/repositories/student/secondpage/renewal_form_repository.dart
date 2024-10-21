import 'package:help_isko/services/student/homepage/renewal_form_service.dart';

class RenewalFormRepository {
  final RenewalFormService renewalFormService;

  RenewalFormRepository({required this.renewalFormService});

  Future<Map<String, dynamic>> submitRenewalForm({
    required String studentNumber,
    required int attendedEvents,
    required String sharedPosts,
    required int dutyHours,
    String? registrationFeePic,
  }) async {
    try {
      final renewalForm = await renewalFormService.submitRenewalForm(
        studentNumber: studentNumber,
        attendedEvents: attendedEvents,
        sharedPosts: sharedPosts,
        dutyHours: dutyHours,
        registrationFeePic: registrationFeePic
      );
      return renewalForm;
    } catch (e) {
      throw Exception('Failed to submit renewal form: $e');
    }
  }
}
