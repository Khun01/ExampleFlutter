import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/duty/prof_duty.dart';
import 'package:help_isko/repositories/duty/duty_repository.dart';

part 'posted_duties_event.dart';
part 'posted_duties_state.dart';

class PostedDutiesBloc extends Bloc<PostedDutiesEvent, PostedDutiesState> {
  final DutyRepository dutyRepository;
  PostedDutiesBloc({required this.dutyRepository})
      : super(PostedDutiesInitial()) {
    on<FetchDuty>(fetchDuty);
    on<RefetchDuty>(refetchDuty);
  }

  FutureOr<void> fetchDuty(
      FetchDuty event, Emitter<PostedDutiesState> emit) async {
    emit(PostedDutiesLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final duty = await dutyRepository.fetchPostedDuties();
      emit(PostedDutiesSuccessState(duty: duty));
    } catch (e) {
      emit(PostedDutiestFailedState(error: e.toString()));
    }
  }

  FutureOr<void> refetchDuty(RefetchDuty event, Emitter<PostedDutiesState> emit) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final duty = await dutyRepository.fetchPostedDuties();
      emit(PostedDutiesSuccessState(duty: duty));
    } catch (e) {
      emit(PostedDutiestFailedState(error: e.toString()));
    }
  }
}
