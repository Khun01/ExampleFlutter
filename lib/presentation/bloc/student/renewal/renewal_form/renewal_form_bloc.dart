import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/presentation/bloc/student/renewal/renewal_form/renewal_form_event.dart';
import 'package:help_isko/presentation/bloc/student/renewal/renewal_form/renewal_form_state.dart';
import 'package:help_isko/repositories/student/secondpage/renewal_form_repository.dart';

class RenewalFormBloc extends Bloc<RenewalFormEvent, RenewalFormState> {
  final RenewalFormRepository renewalFormRepository;

  RenewalFormBloc({required this.renewalFormRepository})
      : super(RenewalFormInitial()) {
    on<SubmitRenewalFormEvent>(_onSubmitRenewalForm);
    // on<FetchSubmittedFormEvent>(_onFetchSubmittedForm);
  }

  Future<void> _onSubmitRenewalForm(
      SubmitRenewalFormEvent event, Emitter<RenewalFormState> emit) async {
    emit(RenewalFormLoading());
    log('The submit renewal is clicked');
    try {
      final response = await renewalFormRepository.submitRenewalForm(
        studentNumber: event.studentNumber,
        attendedEvents: event.attendedEvents,
        sharedPosts: event.sharedPosts, 
        // disbursementMethod: event.disbursementMethod,          // Nullable File
        dutyHours: event.dutyHours,
        registrationFeePic: event.registrationFeePicture, 
      );
      // emit(RenewalFormSuccess(renewalForm));
      final statusCode = response['statusCode'];
      final Map<String, dynamic> responseBody = jsonDecode(response['body']);
      if(statusCode == 201){
        log(responseBody.toString());
        emit(RenewalFormSuccess());
      }else if(statusCode == 400){
        log(responseBody.toString());
        emit(const RenewalFormFailure('Form submission is only allowed when the HK status percentage is 100%.'));
      }else if(statusCode == 409){
        log(responseBody.toString());
        emit(const RenewalFormFailure('You already have a pending renewal form. Please wait for approval before submitting another one.'));
      }else{
        emit(const RenewalFormFailure('Unexpected Error'));
      }
    } catch (e) {
      log(e.toString());
      emit(RenewalFormFailure(e.toString()));
    }
  }

  // // Fetch submitted form handler
  // Future<void> _onFetchSubmittedForm(
  //   FetchSubmittedFormEvent event, Emitter<RenewalFormState> emit) async {
  //   emit(RenewalFormLoading());  // Emit loading state while fetching

  //   try {
  //     // Fetching the submitted form from the repository using the form ID
  //     final renewalForm = await renewalFormRepository.fetchSubmittedForm(event.formId);

  //     // Emitting the success state with the fetched renewal form data
  //     emit(RenewalFormSuccess(renewalForm));
  //   } catch (e) {
  //     // Emitting the failure state with an error message
  //     emit(RenewalFormFailure('Failed to fetch submitted form: ${e.toString()}'));
  //   }
  // }

  // fetchSubmittedForm() {}

  // FutureOr<void> _onSubmitRenewalForm(SubmitRenewalFormEvent event, Emitter<RenewalFormState> emit) {

  // }
}
