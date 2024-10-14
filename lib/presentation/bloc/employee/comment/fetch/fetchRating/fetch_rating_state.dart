part of 'fetch_rating_bloc.dart';

sealed class FetchRatingState extends Equatable {
  const FetchRatingState();
  
  @override
  List<Object> get props => [];
}

final class FetchRatingInitial extends FetchRatingState {}

class FetchRatingLoadingState extends FetchRatingState{}

class FetchRatingSuccessState extends FetchRatingState{
  final Rating rating;

  const FetchRatingSuccessState({required this.rating});
}

class FetchRatingFailedState extends FetchRatingState{
  final String error;

  const FetchRatingFailedState({required this.error});
}