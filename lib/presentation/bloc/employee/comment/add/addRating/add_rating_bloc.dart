import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/repositories/employee/comment_repository.dart';

part 'add_rating_event.dart';
part 'add_rating_state.dart';

class AddRatingBloc extends Bloc<AddRatingEvent, AddRatingState> {
  final CommentRepository commentRepository;
  AddRatingBloc({required this.commentRepository}) : super(AddRatingInitial()) {
    on<AddRatingClickedEvent>(addRatingClickedEvent);
    on<AddRatingResetEvent>(addRatingResetEvent);
  }

  FutureOr<void> addRatingClickedEvent(AddRatingClickedEvent event, Emitter<AddRatingState> emit) async {
    emit(AddRatingLoadingState());
    try{
      await Future.delayed(const Duration(seconds: 2));
      await commentRepository.addRatings(event.addRating, event.studId);
      log('The rating is: ${event.addRating}');
      emit(AddRatingSuccessState());
    }catch(e){
      emit(AddRatingFailedState(error: e.toString()));
    }
  }

  FutureOr<void> addRatingResetEvent(AddRatingResetEvent event, Emitter<AddRatingState> emit) {
    emit(AddRatingInitial());
  }
}
