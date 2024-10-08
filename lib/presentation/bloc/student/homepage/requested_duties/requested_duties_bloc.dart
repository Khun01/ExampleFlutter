import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/student/requested_duties.dart';
import 'package:help_isko/repositories/student/homepage/requested_duties_repository.dart';

part 'requested_duties_event.dart';
part 'requested_duties_state.dart';

class RequestedDutiesBloc
    extends Bloc<RequestedDutiesEvent, RequestedDutiesState> {
  final RequestedDutiesRepository requestedDutiesRepository;
  RequestedDutiesBloc({required this.requestedDutiesRepository})
      : super(RequestedDutiesInitial()) {
    on<RequestedDutiesFetch>(requestedDutiesFetch);
    on<RequestedDutyCancelEvent>(requestedDutyCancelEvent);
  }

  FutureOr<void> requestedDutiesFetch(
      RequestedDutiesFetch event, Emitter<RequestedDutiesState> emit) async {
    emit(RequestedDutiesFetchLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final requestedDuties =
          await requestedDutiesRepository.getRequestedDuties();
      emit(RequestedDutiesFetchSuccessState(requestedDuties: requestedDuties));
    } catch (e) {
      emit(RequestedDutiesFetchFailedState(errorMessage: '$e'));
    }
  }

  FutureOr<void> requestedDutyCancelEvent(RequestedDutyCancelEvent event,
      Emitter<RequestedDutiesState> emit) async {
    emit(RequestedDutiesCancelLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final status =
          await requestedDutiesRepository.cancelRequestedDuties(id: event.id);

      if (status) {
        emit(RequestedDutiesCancelSuccessState());
        add(RequestedDutiesFetch());
      }
    } catch (e) {
      emit(RequestedDutiesFetchFailedState(errorMessage: '$e'));
    }
  }
}
