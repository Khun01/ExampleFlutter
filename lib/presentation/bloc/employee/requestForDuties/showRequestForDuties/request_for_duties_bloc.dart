import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/duty/request_for_duties.dart';
import 'package:help_isko/repositories/duty/request_for_duty_repository.dart';

part 'request_for_duties_event.dart';
part 'request_for_duties_state.dart';

class RequestForDutiesBloc extends Bloc<RequestForDutiesEvent, RequestForDutiesState> {
  final RequestForDutyRepository requestForDutyRepository;
  RequestForDutiesBloc({required this.requestForDutyRepository}) : super(RequestForDutiesInitial()) {
    on<FetchRequestForDutiesEvent>(fetchRequestForDutiesEvent);
  }

  FutureOr<void> fetchRequestForDutiesEvent(FetchRequestForDutiesEvent event, Emitter<RequestForDutiesState> emit) async{
    emit(RequestForDutiesLoadingState());
    try{
      await Future.delayed(const Duration(seconds: 3));
      final requestForDuty = await requestForDutyRepository.fetchRequestForDuties();
      emit(RequestForDutiesSuccessState(requestForDuty: requestForDuty));
    }catch(e){
      emit(RequestForDutiesFailedState(error: e.toString()));
    }
  }
}
