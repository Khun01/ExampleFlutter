part of 'add_comment_bloc.dart';

sealed class AddCommentEvent extends Equatable {
  const AddCommentEvent();

  @override
  List<Object> get props => [];
}

class AddCommentClickedEvent extends AddCommentEvent{
  final String addComment;
  final String studId;
  final FetchCommentBloc fetchCommentBloc;

  const AddCommentClickedEvent(this.fetchCommentBloc, {required this.addComment, required this.studId});
}
