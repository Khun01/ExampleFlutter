part of 'fetch_comment_bloc.dart';

sealed class FetchCommentEvent extends Equatable {
  const FetchCommentEvent();

  @override
  List<Object> get props => [];
}

class FetchCommentsEvent extends FetchCommentEvent{
  final String id;

  const FetchCommentsEvent({required this.id});
}


class UpdateCommentsEvent extends FetchCommentEvent {
  final List<Comment> updatedComments;

  const UpdateCommentsEvent({required this.updatedComments});

  @override
  List<Object> get props => [updatedComments];
}
