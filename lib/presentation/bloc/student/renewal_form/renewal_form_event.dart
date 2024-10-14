import 'dart:io';  // Import for File
import 'package:equatable/equatable.dart';

abstract class RenewalFormEvent extends Equatable {
  const RenewalFormEvent();

  @override
  List<Object?> get props => [];
}

class SubmitRenewalFormEvent extends RenewalFormEvent {
  final String studentNumber;
  final int attendedEvents;
  final int sharedPosts;
  final File? registrationFeePicture;  // Nullable File
  final File? disbursementMethod;  // Nullable File
  final int dutyHours;

  const SubmitRenewalFormEvent({
    required this.studentNumber,
    required this.attendedEvents,
    required this.sharedPosts,
    this.registrationFeePicture,  // Optional
    this.disbursementMethod,  // Optional
    required this.dutyHours,
  });

  @override
  List<Object?> get props => [
        studentNumber,
        attendedEvents,
        sharedPosts,
        registrationFeePicture ?? '',  // Use empty string if null
        disbursementMethod ?? '',  // Use empty string if null
        dutyHours,
      ];
}

// Add the event for fetching the submitted form
class FetchSubmittedFormEvent extends RenewalFormEvent {
  final String formId;  // Identifier for the submitted form

  const FetchSubmittedFormEvent({required this.formId});

  @override
  List<Object?> get props => [formId];
}
