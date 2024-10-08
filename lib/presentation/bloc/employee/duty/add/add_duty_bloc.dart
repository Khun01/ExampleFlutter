import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/duty/prof_duty.dart';
import 'package:help_isko/presentation/bloc/employee/duty/show/posted_duties_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/recentActivity/recent_activities_bloc.dart';
import 'package:help_isko/services/duty/duty_services.dart';

part 'add_duty_event.dart';
part 'add_duty_state.dart';

class AddDutyBloc extends Bloc<AddDutyEvent, AddDutyState> {
  final DutyServices dutyServices;
  AddDutyBloc({required this.dutyServices}) : super(AddDutyInitial()) {
    on<AddDutySubmitButtonClicked>(addDutySubmitButtonClicked);
  }

  FutureOr<void> addDutySubmitButtonClicked(
      AddDutySubmitButtonClicked event, Emitter<AddDutyState> emit) async {
    emit(AddDutyLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final response = await dutyServices.addDuty(
        event.building,
        event.date,
        event.startAt,
        event.endAt,
        event.students,
        event.message,
      );
      final responseBody = jsonDecode(response['body']);
      if (response['statusCode'] == 201) {
        String building = responseBody['building'] ?? '';
        String date = responseBody['date'] ?? '';
        String startTime = responseBody['start_time'] ?? '';
        String endTime = responseBody['end_time'] ?? '';
        String maxScholars = responseBody['max_scholars'] ?? '0';
        String message = responseBody['message'] ?? '';
        ProfDuty profDuty = ProfDuty(
          building: building,
          date: date,
          startTime: startTime,
          endTime: endTime,
          maxScholars: int.tryParse(maxScholars) ?? 0,
          message: message,
        );
        if (event.postedDutiesBloc.state is PostedDutiesSuccessState) {
          final currentState =
              event.postedDutiesBloc.state as PostedDutiesSuccessState;
          final List<ProfDuty> newProfDuty = [...currentState.duty, profDuty];
          log('The new duty is: $currentState');
          event.postedDutiesBloc.add(RefetchDuty(profDuty: newProfDuty));
          event.recentActivitiesBloc
              .add(const FetchRecentActivitiesEvent(role: 'Employee'));
          emit(AddDutySuccessState());
        }
      } else {
        log('Failed to add duty: Response or duty object is null or invalid');
        emit(const AddDutyFailedState(
            error: 'Failed to add duty: Response or duty object is invalid'));
      }
    } catch (e) {
      log('Error when adding duty: $e');
      emit(AddDutyFailedState(error: e.toString()));
    }
  }
}
