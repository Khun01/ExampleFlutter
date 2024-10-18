import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/duty/students.dart';
import 'package:help_isko/repositories/api_repositories.dart';

part 'show_hk_students_event.dart';
part 'show_hk_students_state.dart';

class ShowHkStudentsBloc extends Bloc<ShowHkStudentsEvent, ShowHkStudentsState> {
  final ApiRepositories apiRepositories;
  ShowHkStudentsBloc({required this.apiRepositories}) : super(ShowHkStudentsInitial()) {
    on<FetchHkStudentsEvent>(fetchHkStudentsEvent);
  }

  FutureOr<void> fetchHkStudentsEvent(FetchHkStudentsEvent event, Emitter<ShowHkStudentsState> emit) async{
    emit(ShowHkStudentsLoadingState());
    try{
      // await Future.delayed(const Duration(seconds: 3));
      final students = await apiRepositories.fetchAllStudents();
      emit(ShowHkStudentsSuccessState(students: students));
    }catch(e){
      emit(ShowHkStudentsFailedState(error: e.toString()));
    }
  }
}
