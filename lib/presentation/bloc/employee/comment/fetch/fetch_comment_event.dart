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
