part of 'fetch_comment_bloc.dart';

sealed class FetchCommentState extends Equatable {
  const FetchCommentState();
  
  @override
  List<Object> get props => [];
}

final class FetchCommentInitial extends FetchCommentState {}

class FetchCommentLoadingState extends FetchCommentState{}

class FetchCommentSuccessState extends FetchCommentState{
  final List<Comment> comment;

  const FetchCommentSuccessState({required this.comment});
}

class FetchCommentFailedState extends FetchCommentState{
  final String error;

  const FetchCommentFailedState({required this.error});
}