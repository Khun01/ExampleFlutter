import 'dart:io'; // Import for File
import 'package:equatable/equatable.dart';

abstract class RenewalFormEvent extends Equatable {
  const RenewalFormEvent();

  @override
  List<Object?> get props => [];
}

class SubmitRenewalFormEvent extends RenewalFormEvent {
  final String studentNumber;
  final int attendedEvents;
  final String sharedPosts;
  final String? registrationFeePicture;
  final File? disbursementMethod;
  final int dutyHours;

  const SubmitRenewalFormEvent({
    required this.studentNumber,
    required this.attendedEvents,
    required this.sharedPosts,
    this.registrationFeePicture,
    this.disbursementMethod,
    required this.dutyHours,
  });

  @override
  List<Object?> get props => [
        studentNumber,
        attendedEvents,
        sharedPosts,
        registrationFeePicture ?? '',
        disbursementMethod ?? '',
        dutyHours,
      ];
}

class FetchSubmittedFormEvent extends RenewalFormEvent {
  final String formId;

  const FetchSubmittedFormEvent({required this.formId});

  @override
  List<Object?> get props => [formId];
}
