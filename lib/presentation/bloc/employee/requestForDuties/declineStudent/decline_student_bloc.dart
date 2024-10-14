import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/presentation/bloc/employee/requestForDuties/showRequestForDuties/request_for_duties_bloc.dart';
import 'package:help_isko/repositories/employee/duty/request_for_duty_repository.dart';

part 'decline_student_event.dart';
part 'decline_student_state.dart';

class DeclineStudentBloc extends Bloc<DeclineStudentEvent, DeclineStudentState> {
  final RequestForDutyRepository requestForDutyRepository;
  DeclineStudentBloc({required this.requestForDutyRepository}) : super(DeclineStudentInitial()) {
    on<DeclineStudentButtonClickedEvent>(declineStudentButtonClickedEvent);
  }

  FutureOr<void> declineStudentButtonClickedEvent(DeclineStudentButtonClickedEvent event, Emitter<DeclineStudentState> emit) async {
    emit(DeclineStudentLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 3));
      final response = await requestForDutyRepository.declineStudent(
          event.dutyId, event.studentId);
      if (response['statusCode'] == 200) {
        event.requestForDutiesBloc.add(FetchRequestForDutiesEvent());
        emit(DeclineStudentSuccessState());
      }else{
        log('The decline student is: ${response['statusCode']}');
        emit(const DeclineStudentFailedState(error: 'Failed to decline student'));
      }
    } catch (e) {
      emit(DeclineStudentFailedState(error: e.toString()));
    }
  }
}
