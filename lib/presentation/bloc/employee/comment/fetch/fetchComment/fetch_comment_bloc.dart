import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/data/comment.dart';
import 'package:help_isko/repositories/employee/comment_repository.dart';

part 'fetch_comment_event.dart';
part 'fetch_comment_state.dart';

class FetchCommentBloc extends Bloc<FetchCommentEvent, FetchCommentState> {
  final CommentRepository commentRepository;
  FetchCommentBloc({required this.commentRepository}) : super(FetchCommentInitial()) {
    on<FetchCommentsEvent>(fetchCommentsEvent);
    on<UpdateCommentsEvent>(updateCommentsEvent);
  }

  FutureOr<void> fetchCommentsEvent(FetchCommentsEvent event, Emitter<FetchCommentState> emit) async {
    emit(FetchCommentLoadingState());
    try{
      final comments = await commentRepository.fetchComment(event.id);
      emit(FetchCommentSuccessState(comment: comments));
    }catch(e){
      emit(FetchCommentFailedState(error: e.toString()));
    }
  }

  FutureOr<void> updateCommentsEvent(UpdateCommentsEvent event, Emitter<FetchCommentState> emit) {
    emit(FetchCommentSuccessState(comment: event.updatedComments));
  }
}
