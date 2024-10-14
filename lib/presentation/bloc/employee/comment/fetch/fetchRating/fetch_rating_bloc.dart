import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/data/rating.dart';
import 'package:help_isko/repositories/employee/comment_repository.dart';

part 'fetch_rating_event.dart';
part 'fetch_rating_state.dart';

class FetchRatingBloc extends Bloc<FetchRatingEvent, FetchRatingState> {
  final CommentRepository commentRepository;
  FetchRatingBloc({required this.commentRepository})
      : super(FetchRatingInitial()) {
    on<FetchRatingsEvent>(fetchRatingsEvent);
  }

  FutureOr<void> fetchRatingsEvent(
      FetchRatingsEvent event, Emitter<FetchRatingState> emit) async {
    emit(FetchRatingLoadingState());
    try {
      final rating = await commentRepository.fetchRating(event.id);
      emit(FetchRatingSuccessState(rating: rating));
    } catch (e) {
      emit(FetchRatingFailedState(error: e.toString()));
    }
  }
}
