part of 'decline_student_bloc.dart';

sealed class DeclineStudentState extends Equatable {
  const DeclineStudentState();
  
  @override
  List<Object> get props => [];
}

final class DeclineStudentInitial extends DeclineStudentState {}

class DeclineStudentFailedState extends DeclineStudentState{
  final String error;

  const DeclineStudentFailedState({required this.error});
}

class DeclineStudentSuccessState extends DeclineStudentState{}

class DeclineStudentLoadingState extends DeclineStudentState{}
