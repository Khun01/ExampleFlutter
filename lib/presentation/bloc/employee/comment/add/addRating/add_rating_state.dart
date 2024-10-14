part of 'add_rating_bloc.dart';

sealed class AddRatingState extends Equatable {
  const AddRatingState();
  
  @override
  List<Object> get props => [];
}

final class AddRatingInitial extends AddRatingState {}

class AddRatingLoadingState extends AddRatingState{}

class AddRatingSuccessState extends AddRatingState{
}

class AddRatingFailedState extends AddRatingState{
  final String error;

  const AddRatingFailedState({required this.error});
}