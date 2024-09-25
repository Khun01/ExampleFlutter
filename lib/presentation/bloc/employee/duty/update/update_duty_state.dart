part of 'update_duty_bloc.dart';

sealed class UpdateDutyState extends Equatable {
  const UpdateDutyState();
  
  @override
  List<Object> get props => [];
}

final class UpdateDutyInitial extends UpdateDutyState {}

class UpdateDutyLoadingState extends UpdateDutyState{}

class UpdateDutyFailedState extends UpdateDutyState{
  final String error;

  const UpdateDutyFailedState({required this.error});
}

class UpdateDutySuccessState extends UpdateDutyState{}
