part of 'add_duty_bloc.dart';

sealed class AddDutyEvent extends Equatable {
  const AddDutyEvent();

  @override
  List<Object> get props => [];
}

class AddDutySubmitButtonClicked extends AddDutyEvent {
  final String building;
  final String date;
  final String startAt;
  final String endAt;
  final String students;
  final String message;
  final List<ProfDuty> profDuty;
  final PostedDutiesBloc postedDutiesBloc;
  final RecentActivitiesBloc recentActivitiesBloc;

  const AddDutySubmitButtonClicked(this.building, this.date, this.startAt,
      this.endAt, this.students, this.message,
      {required this.profDuty, required this.postedDutiesBloc, required this.recentActivitiesBloc});
}
