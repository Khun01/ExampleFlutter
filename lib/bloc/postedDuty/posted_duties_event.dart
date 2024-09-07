part of 'posted_duties_bloc.dart';

sealed class PostedDutiesEvent extends Equatable {
  const PostedDutiesEvent();

  @override
  List<Object> get props => [];
}

class FetchDuty extends PostedDutiesEvent{}