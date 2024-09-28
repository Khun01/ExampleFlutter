import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/data/prof_duty.dart';
import 'package:help_isko/presentation/bloc/employee/duty/show/posted_duties_bloc.dart';
import 'package:help_isko/services/duty_services.dart';

part 'add_duty_event.dart';
part 'add_duty_state.dart';

class AddDutyBloc extends Bloc<AddDutyEvent, AddDutyState> {
  final DutyServices dutyServices;
  AddDutyBloc({required this.dutyServices}) : super(AddDutyInitial()) {
    on<AddDutySubmitButtonClicked>(addDutySubmitButtonClicked);
  }

  FutureOr<void> addDutySubmitButtonClicked(
      AddDutySubmitButtonClicked event, Emitter<AddDutyState> emit) async {
    log('The submit button is cliked');
    emit(AddDutyLoadingState());
    try {
      final profDuty = ProfDuty(
          building: event.building,
          date: event.date,
          startTime: event.startAt,
          endTime: event.endAt,
          maxScholars: int.tryParse(event.students),
          message: event.message);
      await Future.delayed(const Duration(seconds: 2));
      final duty = await dutyServices.addDuty(profDuty);
      if (duty['statusCode'] == 201) {
        event.postedDutiesBloc.add(FetchDuty());
        emit(AddDutySuccessState());
      } else {
        log('Failed to add duty: ${duty['statusCode']}');
        emit(AddDutyFailedState(
            error: 'Failed to add duty: ${duty['statusCode']}'));
      }
    } catch (e) {
      emit(AddDutyFailedState(error: e.toString()));
    }
  }
}
