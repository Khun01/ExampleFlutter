part of 'completed_duty_bloc.dart';

sealed class CompletedDutyState extends Equatable {
  const CompletedDutyState();

  @override
  List<Object> get props => [];
}

final class CompletedDutyInitial extends CompletedDutyState {}

class CompletedDutySuccessState extends CompletedDutyState {
  final List<CompletedDuty> completedDuty;

  const CompletedDutySuccessState({required this.completedDuty});
}

class CompletedDutyFailedState extends CompletedDutyState {
  final String error;

  const CompletedDutyFailedState({required this.error});
}

class CompletedDutyLoadingState extends CompletedDutyState {}

class AddDutyHourLoadingState extends CompletedDutyState {}

class AddDutyHourSuccessState extends CompletedDutyState {}

class AddDutyHourFailedState extends CompletedDutyState {
  final String errorMessage;

  const AddDutyHourFailedState({required this.errorMessage});
}
