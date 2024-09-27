part of 'update_duty_bloc.dart';

sealed class UpdateDutyEvent extends Equatable {
  const UpdateDutyEvent();

  @override
  List<Object> get props => [];
}

class UpdateDutyButtonClickedEvent extends UpdateDutyEvent {
  final String building;
  final String date;
  final String startAt;
  final String endAt;
  final String message;
  final String student;
  final ProfDuty profDuty;

  const UpdateDutyButtonClickedEvent(this.building, this.date, this.startAt,
      this.endAt, this.message, this.student,
      {required this.profDuty});
}
