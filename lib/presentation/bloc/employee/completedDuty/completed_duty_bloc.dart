import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/repositories/employee/duty/duty_repository.dart';

part 'completed_duty_event.dart';
part 'completed_duty_state.dart';

class CompletedDutyBloc extends Bloc<CompletedDutyEvent, CompletedDutyState> {
  final DutyRepository dutyRepository;
  CompletedDutyBloc({required this.dutyRepository}) : super(CompletedDutyInitial()) {
    on<DutyCompletedFetch>(dutyCompletedFetch);
  }

  FutureOr<void> dutyCompletedFetch(DutyCompletedFetch event, Emitter<CompletedDutyState> emit) async{
    emit(CompletedDutyLoadingState());
    try{
      await dutyRepository.fetchCompletedDutyByStudent();
      emit(CompletedDutySuccessState());
    }catch(e){
      emit(CompletedDutyFailedState(error: e.toString()));
    }
  }
}
