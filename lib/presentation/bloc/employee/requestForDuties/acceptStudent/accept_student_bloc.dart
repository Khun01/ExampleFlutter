import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/repositories/duty/request_for_duty_repository.dart';

part 'accept_student_event.dart';
part 'accept_student_state.dart';

class AcceptStudentBloc extends Bloc<AcceptStudentEvent, AcceptStudentState> {
  final RequestForDutyRepository requestForDutyRepository;
  AcceptStudentBloc({required this.requestForDutyRepository})
      : super(AcceptStudentInitial()) {
    on<AcceptStudentButtonClickedEvent>(acceptStudentButtonClickedEvent);
  }

  FutureOr<void> acceptStudentButtonClickedEvent(
      AcceptStudentButtonClickedEvent event,
      Emitter<AcceptStudentState> emit) async {
    emit(AcceptStudentLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 3));
      log('The button Accept Stundent is clicked: Duty ID: ${event.dutyId}, Student ID: ${event.studentId}');
      emit(AcceptStudentSuccessSate());
    } catch (e) {
      emit(AcceptStudentFailedState(error: e.toString()));
    }
  }
}
