part of 'completed_duty_bloc.dart';

sealed class CompletedDutyState extends Equatable {
  const CompletedDutyState();
  
  @override
  List<Object> get props => [];
}

final class CompletedDutyInitial extends CompletedDutyState {}

class CompletedDutySuccessState extends CompletedDutyState{}

class CompletedDutyFailedState extends CompletedDutyState {
  final String error;

  const CompletedDutyFailedState({required this.error});
}
 
class CompletedDutyLoadingState extends CompletedDutyState{}