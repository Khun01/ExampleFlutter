part of 'posted_duties_bloc.dart';

sealed class PostedDutiesState extends Equatable {
  const PostedDutiesState();
  
  @override
  List<Object> get props => [];
}

final class PostedDutiesInitial extends PostedDutiesState {}


class PostedDutiestFailedState extends PostedDutiesState{
  final String error;

  const PostedDutiestFailedState ({required this.error});
}

class PostedDutiesLoadingState extends PostedDutiesState{}

class PostedDutiesSuccessState extends PostedDutiesState{
  final List<ProfDuty> duty;

  const PostedDutiesSuccessState ({required this.duty});
}

class PostingDutiesSuccessState extends PostedDutiesState{}