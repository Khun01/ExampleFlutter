part of 'add_duty_bloc.dart';

sealed class AddDutyState extends Equatable {
  const AddDutyState();
  
  @override
  List<Object> get props => [];
}

final class AddDutyInitial extends AddDutyState {}

class AddDutyLoadingState extends AddDutyState{}

class AddDutySuccessState extends AddDutyState{}

class AddDutyFailedState extends AddDutyState{
  final String error;

  const AddDutyFailedState({required this.error});
}
