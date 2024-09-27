part of 'delete_duty_bloc.dart';

sealed class DeleteDutyEvent extends Equatable {
  const DeleteDutyEvent();

  @override
  List<Object> get props => [];
}

class DeleteDutyButtonClickedEvent extends DeleteDutyEvent{
  final ProfDuty profDuty;

  const DeleteDutyButtonClickedEvent({required this.profDuty});
}
