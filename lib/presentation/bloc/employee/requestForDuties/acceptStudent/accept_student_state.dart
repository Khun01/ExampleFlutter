part of 'accept_student_bloc.dart';

sealed class AcceptStudentState extends Equatable {
  const AcceptStudentState();
  
  @override
  List<Object> get props => [];
}

final class AcceptStudentInitial extends AcceptStudentState {}

class AcceptStudentFailedState extends AcceptStudentState{
  final String error;

  const AcceptStudentFailedState({required this.error});
}

class AcceptStudentSuccessSate extends AcceptStudentState{}

class AcceptStudentLoadingState extends AcceptStudentState{}
