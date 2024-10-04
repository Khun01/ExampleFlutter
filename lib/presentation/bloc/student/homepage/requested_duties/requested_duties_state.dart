part of 'requested_duties_bloc.dart';

sealed class RequestedDutiesState extends Equatable {
  const RequestedDutiesState();

  @override
  List<Object> get props => [];
}

final class RequestedDutiesInitial extends RequestedDutiesState {}

class RequestedDutiesFetchLoadingState extends RequestedDutiesState {}

class RequestedDutiesFetchSuccessState extends RequestedDutiesState {
  final List<RequestedDuties> requestedDuties;

  const RequestedDutiesFetchSuccessState({required this.requestedDuties});
}

class RequestedDutiesFetchFailedState extends RequestedDutiesState {
  final String errorMessage;

  const RequestedDutiesFetchFailedState({required this.errorMessage});
}

class RequestedDutiesCancelLoadingState extends RequestedDutiesState {}

class RequestedDutiesCancelSuccessState extends RequestedDutiesState {}

// class RequestedDutiesCancelFailedState extends RequestedDutiesState {
//   final String errorMessage;

//   const RequestedDutiesCancelFailedState({required this.errorMessage});
// }
