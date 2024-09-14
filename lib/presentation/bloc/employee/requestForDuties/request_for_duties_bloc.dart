import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'request_for_duties_event.dart';
part 'request_for_duties_state.dart';

class RequestForDutiesBloc extends Bloc<RequestForDutiesEvent, RequestForDutiesState> {
  RequestForDutiesBloc() : super(RequestForDutiesInitial()) {
    on<FetchRequestForDutiesEvent>(fetchRequestForDutiesEvent);
  }

  FutureOr<void> fetchRequestForDutiesEvent(FetchRequestForDutiesEvent event, Emitter<RequestForDutiesState> emit) async{
    
  }
}
