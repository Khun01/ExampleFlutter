import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/presentation/bloc/employee/comment/fetch/fetch_comment_bloc.dart';
import 'package:help_isko/repositories/api_repositories.dart';

part 'add_comment_event.dart';
part 'add_comment_state.dart';

class AddCommentBloc extends Bloc<AddCommentEvent, AddCommentState> {
  final ApiRepositories apiRepositories;
  AddCommentBloc({required this.apiRepositories}) : super(AddCommentInitial()) {
    on<AddCommentClickedEvent>(addCommentClickedEvent);
  }

  FutureOr<void> addCommentClickedEvent(
      AddCommentClickedEvent event, Emitter<AddCommentState> emit) async {
    emit(AddCommentLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      await apiRepositories.addComment(event.addComment, event.studId);
      event.fetchCommentBloc.add(FetchCommentsEvent(id: event.studId));
      emit(AddCommentSuccessState());
    } catch (e) {
      emit(AddCommentFailedState(error: e.toString()));
    }
  }
}
