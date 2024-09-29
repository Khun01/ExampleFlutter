part of 'accept_student_bloc.dart';

sealed class AcceptStudentEvent extends Equatable {
  const AcceptStudentEvent();

  @override
  List<Object> get props => [];
}

class AcceptStudentButtonClickedEvent extends AcceptStudentEvent {
  final int dutyId;
  final int studentId;
  final RequestForDutiesBloc requestForDutiesBloc;

  const AcceptStudentButtonClickedEvent(
      {required this.dutyId,
      required this.studentId,
      required this.requestForDutiesBloc});
}
