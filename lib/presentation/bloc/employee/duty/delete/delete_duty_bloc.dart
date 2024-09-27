import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/data/prof_duty.dart';
import 'package:help_isko/services/duty_services.dart';

part 'delete_duty_event.dart';
part 'delete_duty_state.dart';

class DeleteDutyBloc extends Bloc<DeleteDutyEvent, DeleteDutyState> {
  final DutyServices dutyServices;
  DeleteDutyBloc({required this.dutyServices}) : super(DeleteDutyInitial()) {
    on<DeleteDutyButtonClickedEvent>(deleteDutyButtonClickedEvent);
  }

  FutureOr<void> deleteDutyButtonClickedEvent(DeleteDutyButtonClickedEvent event, Emitter<DeleteDutyState> emit) async {
    emit(DeleteDutyLoadingState());
    try{  
      await Future.delayed(const Duration(seconds: 3));
      final response = await dutyServices.deleteDuty(event.profDuty.id!);
      if(response['statusCode'] == 200){
        emit(DeleteDutySuccessState());
      }else{
        emit(const DeleteDutyFailedState(error: 'Failed to delete duty'));
      }
    }catch(e){
      emit(DeleteDutyFailedState(error: e.toString()));
    }
  }
}
