part of 'add_rating_bloc.dart';

sealed class AddRatingEvent extends Equatable {
  const AddRatingEvent();

  @override
  List<Object> get props => [];
}

class AddRatingClickedEvent extends AddRatingEvent{
  final int addRating;
  final String studId;

  const AddRatingClickedEvent({required this.addRating, required this.studId});
}

class AddRatingResetEvent extends AddRatingEvent{}