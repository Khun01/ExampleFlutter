part of 'duties_bloc.dart';

sealed class DutiesState extends Equatable {
  const DutiesState();

  @override
  List<Object> get props => [];
}

final class DutiesInitial extends DutiesState {}

class DutiesFetchLoading extends DutiesState {}

class DutiesFetchSuccess extends DutiesState {
  final List<AvailableDuty> availableDuties;

  const DutiesFetchSuccess({required this.availableDuties});
}

class DutiesFetchFailed extends DutiesState {
  final String errorMessage;

  const DutiesFetchFailed({required this.errorMessage});
}

class DutiesAcceptLoading extends DutiesState {}

class DutiesAcceptSuccess extends DutiesState {}

class DutiesAcceptFailed extends DutiesState {
  final String errorMessage;

  const DutiesAcceptFailed({required this.errorMessage});
}
