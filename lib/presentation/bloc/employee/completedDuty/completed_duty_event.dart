part of 'completed_duty_bloc.dart';

sealed class CompletedDutyEvent extends Equatable {
  const CompletedDutyEvent();

  @override
  List<Object> get props => [];
}

class DutyCompletedFetch extends CompletedDutyEvent {}

class DutyAddHoursStudent extends CompletedDutyEvent {
  final int hour;
  final int minute;
  final int studentId;
  final int dutyId;

  DutyAddHoursStudent({required this.hour, required this.minute, required this.studentId, required this.dutyId});
}
