import 'dart:io';  
import 'package:help_isko/models/student/renewal_form.dart';
import 'package:help_isko/services/student/homepage/renewal_form_service.dart';

class RenewalFormRepository {
  final RenewalFormService renewalFormService;

  RenewalFormRepository({required this.renewalFormService});

  Future<RenewalForm> submitRenewalForm({
    required String studentNumber,
    required int attendedEvents,
    required int sharedPosts,
    required File? registrationFeePicture,  // File type
    required File? disbursementMethod,  // File type
    required int dutyHours,
  }) async {
    try {
      final renewalForm = await renewalFormService.submitRenewalForm(
        studentNumber: studentNumber,
        attendedEvents: attendedEvents,
        sharedPosts: sharedPosts,
        registrationFeePicture: registrationFeePicture,  // Pass File
        disbursementMethod: disbursementMethod,  // Pass File
        dutyHours: dutyHours,
      );
      return renewalForm;
    } catch (e) {
      throw Exception('Failed to submit renewal form: $e');
    }
  }

  // New method to fetch submitted form based on form ID
  Future<RenewalForm> fetchSubmittedForm(String formId) async {
    try {
      // Call the service to fetch the renewal form from the Laravel API by ID
      final fetchedForm = await renewalFormService.getRenewalFormById(formId);
      return fetchedForm;
    } catch (e) {
      throw Exception('Failed to fetch submitted form: $e');
    }
  }
}
