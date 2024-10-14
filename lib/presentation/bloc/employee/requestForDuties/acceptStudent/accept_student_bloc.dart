import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/presentation/bloc/employee/requestForDuties/showRequestForDuties/request_for_duties_bloc.dart';
import 'package:help_isko/repositories/employee/duty/request_for_duty_repository.dart';

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
      final response = await requestForDutyRepository.acceptStudent(
          event.dutyId, event.studentId);
      if (response['statusCode'] == 200) {
        event.requestForDutiesBloc.add(FetchRequestForDutiesEvent());
        emit(AcceptStudentSuccessSate());
      }else{
        emit(const AcceptStudentFailedState(error: 'Failed to accept student'));
      }
    } catch (e) {
      emit(AcceptStudentFailedState(error: e.toString()));
    }
  }
}
