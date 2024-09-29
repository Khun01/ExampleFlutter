part of 'request_for_duties_bloc.dart';

sealed class RequestForDutiesEvent extends Equatable {
  const RequestForDutiesEvent();

  @override
  List<Object> get props => [];
}

class FetchRequestForDutiesEvent extends RequestForDutiesEvent{}
