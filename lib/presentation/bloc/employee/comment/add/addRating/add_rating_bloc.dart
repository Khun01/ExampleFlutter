import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/presentation/bloc/employee/comment/fetch/fetchRating/fetch_rating_bloc.dart';
import 'package:help_isko/repositories/employee/comment_repository.dart';

part 'add_rating_event.dart';
part 'add_rating_state.dart';

class AddRatingBloc extends Bloc<AddRatingEvent, AddRatingState> {
  final CommentRepository commentRepository;
  AddRatingBloc({required this.commentRepository}) : super(AddRatingInitial()) {
    on<AddRatingClickedEvent>(addRatingClickedEvent);
  }

  FutureOr<void> addRatingClickedEvent(AddRatingClickedEvent event, Emitter<AddRatingState> emit) async {
    emit(AddRatingLoadingState());
    try{
      log('The rating is: ${event.addRating}');
      
    }catch(e){
      emit(AddRatingFailedState(error: e.toString()));
    }
  }
}
