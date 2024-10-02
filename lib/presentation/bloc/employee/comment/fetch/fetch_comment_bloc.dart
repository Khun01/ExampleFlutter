import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/data/comment.dart';
import 'package:help_isko/repositories/api_repositories.dart';

part 'fetch_comment_event.dart';
part 'fetch_comment_state.dart';

class FetchCommentBloc extends Bloc<FetchCommentEvent, FetchCommentState> {
  final ApiRepositories apiRepositories;
  FetchCommentBloc({required this.apiRepositories}) : super(FetchCommentInitial()) {
    on<FetchCommentsEvent>(fetchCommentsEvent);
  }

  FutureOr<void> fetchCommentsEvent(FetchCommentsEvent event, Emitter<FetchCommentState> emit) async {
    emit(FetchCommentLoadingState());
    try{
      final comments = await apiRepositories.fetchComment(event.id);
      emit(FetchCommentSuccessState(comment: comments));
    }catch(e){
      emit(FetchCommentFailedState(error: e.toString()));
    }
  }
}
