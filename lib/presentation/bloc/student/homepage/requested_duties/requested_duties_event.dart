part of 'requested_duties_bloc.dart';

sealed class RequestedDutiesEvent extends Equatable {
  const RequestedDutiesEvent();

  @override
  List<Object> get props => [];
}

class RequestedDutiesFetch extends RequestedDutiesEvent {}

class RequestedDutyCancelEvent extends RequestedDutiesEvent {
  final int id;

  const RequestedDutyCancelEvent({required this.id});
}
