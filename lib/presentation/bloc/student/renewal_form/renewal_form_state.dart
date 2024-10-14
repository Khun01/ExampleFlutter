import 'package:equatable/equatable.dart';
import 'package:help_isko/models/student/renewal_form.dart';

abstract class RenewalFormState extends Equatable {
  const RenewalFormState();

  @override
  List<Object?> get props => [];
}

class RenewalFormInitial extends RenewalFormState {}

class RenewalFormLoading extends RenewalFormState {}

class RenewalFormSuccess extends RenewalFormState {
  final RenewalForm renewalForm;

  const RenewalFormSuccess(this.renewalForm);

  @override
  List<Object?> get props => [renewalForm];
}

class RenewalFormFailure extends RenewalFormState {
  final String error;

  const RenewalFormFailure(this.error);

  @override
  List<Object?> get props => [error];
}
