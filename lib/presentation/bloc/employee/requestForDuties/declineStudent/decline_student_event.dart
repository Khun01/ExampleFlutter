part of 'decline_student_bloc.dart';

sealed class DeclineStudentEvent extends Equatable {
  const DeclineStudentEvent();

  @override
  List<Object> get props => [];
}

class DeclineStudentButtonClickedEvent extends DeclineStudentEvent {
  final int dutyId;
  final int studentId;
  final RequestForDutiesBloc requestForDutiesBloc;

  const DeclineStudentButtonClickedEvent(
      {required this.dutyId,
      required this.studentId,
      required this.requestForDutiesBloc});
}