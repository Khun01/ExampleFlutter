import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/duty/prof_duty.dart';
import 'package:help_isko/services/duty/duty_services.dart';

part 'update_duty_event.dart';
part 'update_duty_state.dart';

class UpdateDutyBloc extends Bloc<UpdateDutyEvent, UpdateDutyState> {
  final DutyServices dutyServices;
  UpdateDutyBloc({required this.dutyServices}) : super(UpdateDutyInitial()) {
    on<UpdateDutyButtonClickedEvent>(updateDutyButtonClickedEvent);
  }

  FutureOr<void> updateDutyButtonClickedEvent(UpdateDutyButtonClickedEvent event, Emitter<UpdateDutyState> emit) async{
    emit(UpdateDutyLoadingState());
    try{
      final updatedProfDuty = ProfDuty(
        building: event.building,
        date: event.date,
        startTime: event.startAt,
        endTime: event.endAt,
        message: event.message,
        maxScholars: int.tryParse(event.student),
      );
      log('The updated data is: ${updatedProfDuty.building}, ${event.date}, ${event.startAt}, ${event.endAt}, ${event.message}, ${event.student}, ');
      await Future.delayed(const Duration(seconds: 3));
      final response = await dutyServices.updateDuty(event.profDuty.id!, updatedProfDuty);
      if(response['statusCode'] == 200){
        emit(UpdateDutySuccessState());
      }else{
        log('The error in updating duty is: ${response['statusCode']}, ${response['body']}, ${response['headers']}');
        emit(const UpdateDutyFailedState(error: 'Failed to update duty'));
      }
    }catch(e){
      emit(UpdateDutyFailedState(error: e.toString()));
    }
  }
}
