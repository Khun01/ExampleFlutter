import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/data/comment.dart';
import 'package:help_isko/presentation/bloc/employee/comment/fetch/fetch_comment_bloc.dart';
import 'package:help_isko/repositories/api_repositories.dart';

part 'add_comment_event.dart';
part 'add_comment_state.dart';

class AddCommentBloc extends Bloc<AddCommentEvent, AddCommentState> {
  final ApiRepositories apiRepositories;
  final FetchCommentBloc fetchCommentBloc;
  AddCommentBloc(
      {required this.apiRepositories, required this.fetchCommentBloc})
      : super(AddCommentInitial()) {
    on<AddCommentClickedEvent>(addCommentClickedEvent);
  }

  FutureOr<void> addCommentClickedEvent(
      AddCommentClickedEvent event, Emitter<AddCommentState> emit) async {
    emit(AddCommentLoadingState());
    try {
      final response =
          await apiRepositories.addComment(event.addComment, event.studId);
      final responseBody = jsonDecode(response['body']);
      String comment = responseBody['comment'];
      Comment newComment = Comment(
        comment: comment,
      );
      if (event.fetchCommentBloc.state is FetchCommentSuccessState) {
        final currentState =
            event.fetchCommentBloc.state as FetchCommentSuccessState;
        final List<Comment> updatedComments = [
          ...currentState.comment,
          newComment
        ];
        event.fetchCommentBloc
            .add(UpdateCommentsEvent(updatedComments: updatedComments));
        emit(AddCommentSuccessState());
      }
      // await apiRepositories.addComment(event.addComment, event.studId);
      // event.fetchCommentBloc.add(FetchCommentsEvent(id: event.studId));
      // emit(AddCommentSuccessState());
    } catch (e) {
      log('Error adding comment: $e');
      emit(AddCommentFailedState(error: e.toString()));
    }
  }
}
