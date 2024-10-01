part of 'show_hk_students_bloc.dart';

sealed class ShowHkStudentsEvent extends Equatable {
  const ShowHkStudentsEvent();

  @override
  List<Object> get props => [];
}

class FetchHkStudentsEvent extends ShowHkStudentsEvent{}
