part of 'fetch_rating_bloc.dart';

sealed class FetchRatingEvent extends Equatable {
  const FetchRatingEvent();

  @override
  List<Object> get props => [];
}

class FetchRatingsEvent extends FetchRatingEvent{
  final String id;

  const FetchRatingsEvent({required this.id});
}


class UpdateRatingEvent extends FetchRatingEvent {
  final List<Rating> updatedRating;

  const UpdateRatingEvent({required this.updatedRating});

  @override
  List<Object> get props => [updatedRating];
}