part of 'delete_duty_bloc.dart';

sealed class DeleteDutyState extends Equatable {
  const DeleteDutyState();
  
  @override
  List<Object> get props => [];
}

final class DeleteDutyInitial extends DeleteDutyState {}

class DeleteDutySuccessState extends DeleteDutyState {}

class DeleteDutyLoadingState extends DeleteDutyState {}

class DeleteDutyFailedState extends DeleteDutyState {
  final String error;

  const DeleteDutyFailedState({required this.error});
}