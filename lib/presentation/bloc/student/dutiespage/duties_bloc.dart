// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:help_isko/models/student/available_duty.dart';
import 'package:help_isko/repositories/student/dutiespage/available_duties_repository.dart';

part 'duties_event.dart';
part 'duties_state.dart';

class DutiesBloc extends Bloc<DutiesEvent, DutiesState> {
  final AvailableDutiesRepository availableDutiesRepository;
  DutiesBloc(
    this.availableDutiesRepository,
  ) : super(DutiesInitial()) {
    on<DutiesAvailableFetch>(dutiesAvailableFetch);
    on<DutiesAcceptEvent>(dutiesAcceptEvent);
  }

  FutureOr<void> dutiesAvailableFetch(
      DutiesAvailableFetch event, Emitter<DutiesState> emit) async {
    emit(DutiesFetchLoading());
    try {
      // await Future.delayed(const Duration(seconds: 2));
      final List<AvailableDuty> availableDuties =
          await availableDutiesRepository.getAvailableDuties();
      emit(DutiesFetchSuccess(availableDuties: availableDuties));
    } catch (e) {
      emit(DutiesFetchFailed(errorMessage: '$e'));
    }
  }

  FutureOr<void> dutiesAcceptEvent(
      DutiesAcceptEvent event, Emitter<DutiesState> emit) async {
    emit(DutiesAcceptLoading());
    try {
      // await Future.delayed(const Duration(seconds: 2));
      final status = await availableDutiesRepository.acceptDuty(event.id);
      if (status) {
        emit(DutiesAcceptSuccess());
      }
    } catch (e) {
      emit(DutiesAcceptFailed(errorMessage: '$e'));
    }
  }
}
