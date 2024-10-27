import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/employee/duty/prof_duty.dart';
import 'package:help_isko/repositories/employee/duty/duty_repository.dart';

part 'posted_duties_event.dart';
part 'posted_duties_state.dart';

class PostedDutiesBloc extends Bloc<PostedDutiesEvent, PostedDutiesState> {
  final DutyRepository dutyRepository;
  PostedDutiesBloc({required this.dutyRepository})
      : super(PostedDutiesInitial()) {
    on<FetchDuty>(fetchDuty);
    on<RefetchDuty>(refetchDuty);
    on<FetchCompletedDuty>(fetchCompletedDuty);
  }

  FutureOr<void> fetchDuty(
      FetchDuty event, Emitter<PostedDutiesState> emit) async {
    emit(PostedDutiesLoadingState());
    try {
      // await Future.delayed(const Duration(seconds: 2));
      final duty = await dutyRepository.fetchPostedDuties();
      emit(PostedDutiesSuccessState(duty: duty));
    } catch (e) {
      emit(PostedDutiestFailedState(error: e.toString()));
    }
  }

  FutureOr<void> refetchDuty(
      RefetchDuty event, Emitter<PostedDutiesState> emit) async {
    emit(PostedDutiesSuccessState(duty: event.profDuty));
  }

  FutureOr<void> fetchCompletedDuty(
      FetchCompletedDuty event, Emitter<PostedDutiesState> emit) async {
    emit(PostedDutiesLoadingState());
    try {
      // await Future.delayed(const Duration(seconds: 2));
      final duty = await dutyRepository.fetchCompletedPostedDuties();
      emit(PostedDutiesSuccessState(duty: duty));
    } catch (e) {
      emit(PostedDutiestFailedState(error: e.toString()));
    }
  }
}
