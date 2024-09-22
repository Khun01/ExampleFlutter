// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class MessageFetchEvent extends MessageEvent {
  final String role;
  const MessageFetchEvent({
    required this.role,
  });
}

class MessagePusherExistingChatsEvent extends MessageEvent {
  final String role;
  const MessagePusherExistingChatsEvent({
    required this.role,
  });
}

class MessageNavigateToChatEvent extends MessageEvent {
  final String role;
  final int targetUserId;
  const MessageNavigateToChatEvent({
    required this.role,
    required this.targetUserId,
  });
}

class MessagePusherChatEvent extends MessageEvent {
  final String role;
  final int targetUserId;
  MessagePusherChatEvent({
    required this.role,
    required this.targetUserId,
  });
}

class MessagePusherEventData extends MessageEvent {
  dynamic data;
  String role;
  MessagePusherEventData({required this.data, required this.role});
}

class MessageSendEvent extends MessageEvent {
  String role;
  String message;
  int targetUserId;
  MessageSendEvent({
    required this.role,
    required this.message,
    required this.targetUserId,
  });
}

class MessageDisposeEvent extends MessageEvent {}
