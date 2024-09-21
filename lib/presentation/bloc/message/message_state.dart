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
  const MessageExisitingChatsFetchFailedState({
    required this.errorMessage,
  });
}

class MessageNavigatetoChatState extends MessageState {
  final int targetUserId;

  const MessageNavigatetoChatState({required this.targetUserId});

  @override
  List<Object> get props => [targetUserId];
}

class MessageDisposeState extends MessageState {}

class MessageFetchLoadingChatState extends MessageState {}

class MessageFetchSuccessChatState extends MessageState {
  List<Message> chats;
  final int currentUserId;

  MessageFetchSuccessChatState(this.chats, this.currentUserId);

  @override
  List<Object> get props => [chats, currentUserId];
}

class MessageFetchFailedChatState extends MessageState {
  final String errorMessage;
  const MessageFetchFailedChatState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class MessageSendFailedState extends MessageState {
  String errorMessage;
  MessageSendFailedState({
    required this.errorMessage,
  });
}