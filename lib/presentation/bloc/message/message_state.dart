// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'message_bloc.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

final class MessageInitial extends MessageState {}

class MessageExisitingChatsFetchLoadingState extends MessageState {}

class MessageExisitingChatsFetchSuccessState extends MessageState {
  final int currentUserId;
  final List<ExistingChat> existingChats;
  const MessageExisitingChatsFetchSuccessState(
      {required this.existingChats, required this.currentUserId});

  @override
  List<Object> get props => [existingChats, currentUserId];
}

class MessageExisitingChatsFetchFailedState extends MessageState {
  final String errorMessage;
  MessageExisitingChatsFetchFailedState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
