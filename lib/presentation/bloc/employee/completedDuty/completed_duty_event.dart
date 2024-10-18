part of 'completed_duty_bloc.dart';

sealed class CompletedDutyEvent extends Equatable {
  const CompletedDutyEvent();

  @override
  List<Object> get props => [];
}

class DutyCompletedFetch extends CompletedDutyEvent {}
