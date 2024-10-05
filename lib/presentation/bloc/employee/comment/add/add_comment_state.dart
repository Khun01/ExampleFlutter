part of 'add_comment_bloc.dart';

sealed class AddCommentState extends Equatable {
  const AddCommentState();
  
  @override
  List<Object> get props => [];
}

final class AddCommentInitial extends AddCommentState {}

class AddCommentLoadingState extends AddCommentState{}

class AddCommentSuccessState extends AddCommentState{
}

class AddCommentFailedState extends AddCommentState{
  final String error;

  const AddCommentFailedState({required this.error});
}