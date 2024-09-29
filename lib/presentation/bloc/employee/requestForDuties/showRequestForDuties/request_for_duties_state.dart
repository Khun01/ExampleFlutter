part of 'request_for_duties_bloc.dart';

sealed class RequestForDutiesState extends Equatable {
  const RequestForDutiesState();
  
  @override
  List<Object> get props => [];
}

final class RequestForDutiesInitial extends RequestForDutiesState {}

class RequestForDutiesSuccessState extends RequestForDutiesState {
  final List<RequestForDuties> requestForDuty;

  const RequestForDutiesSuccessState({required this.requestForDuty});
}

class RequestForDutiesLoadingState extends RequestForDutiesState {}

class RequestForDutiesFailedState extends RequestForDutiesState {
  final String error;
  
  const RequestForDutiesFailedState({required this.error});
}
