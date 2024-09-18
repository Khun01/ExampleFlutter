// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class MessageFetchEvent extends MessageEvent {
  String role;
  MessageFetchEvent({
    required this.role,
  });
}

class MessagePusherExistingChatsEvent extends MessageEvent {
  String role;
  MessagePusherExistingChatsEvent({
    required this.role,
  });
}
