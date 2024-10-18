import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/duty/completed_duty.dart';
import 'package:help_isko/repositories/employee/duty/duty_repository.dart';

part 'completed_duty_event.dart';
part 'completed_duty_state.dart';

class CompletedDutyBloc extends Bloc<CompletedDutyEvent, CompletedDutyState> {
  final DutyRepository dutyRepository;
  CompletedDutyBloc({required this.dutyRepository})
      : super(CompletedDutyInitial()) {
    on<DutyCompletedFetch>(dutyCompletedFetch);
    on<DutyAddHoursStudent>(dutyAddHoursStudent);
  }

  FutureOr<void> dutyCompletedFetch(
      DutyCompletedFetch event, Emitter<CompletedDutyState> emit) async {
    emit(CompletedDutyLoadingState());
    try {
      final comepletedDuty = await dutyRepository.fetchCompletedDutyByStudent();
      emit(CompletedDutySuccessState(completedDuty: comepletedDuty));
      print('nag emit na');
    } catch (e) {
      emit(CompletedDutyFailedState(error: e.toString()));
    }
  }

  FutureOr<void> dutyAddHoursStudent(
      DutyAddHoursStudent event, Emitter<CompletedDutyState> emit) async {
    emit(CompletedDutyLoadingState());
    try {
      final res = await dutyRepository.addHourStudent(
          hour: event.hour,
          minute: event.minute,
          studentId: event.studentId,
          dutyId: event.dutyId);

      if (res) {
        emit(AddDutyHourSuccessState());
        // add(DutyCompletedFetch());
      }else{
        emit(const AddDutyHourFailedState(errorMessage: 'Wrong hours and minutes'));
      }
    } catch (e) {
      emit(AddDutyHourFailedState(errorMessage: '$e'));
    }
  }
}
