part of 'show_hk_students_bloc.dart';

sealed class ShowHkStudentsState extends Equatable {
  const ShowHkStudentsState();
  
  @override
  List<Object> get props => [];
}

final class ShowHkStudentsInitial extends ShowHkStudentsState {}

class ShowHkStudentsSuccessState extends ShowHkStudentsState{
  final List<Students> students;

  const ShowHkStudentsSuccessState({required this.students});
}

class ShowHkStudentsFailedState extends ShowHkStudentsState{
  final String error;

  const ShowHkStudentsFailedState({required this.error});
}

class ShowHkStudentsLoadingState extends ShowHkStudentsState{}