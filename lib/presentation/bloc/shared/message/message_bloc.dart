import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/message/existing_chat.dart';
import 'package:help_isko/models/message/message.dart';
import 'package:help_isko/repositories/messenger_repositories.dart';
import 'package:help_isko/repositories/storage/employee_storage.dart';
import 'package:help_isko/repositories/storage/student_storage.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessengerRepository messengerRepository;
  MessageBloc({required this.messengerRepository}) : super(MessageInitial()) {
    on<MessageEvent>(messageEvent);
    on<MessageFetchEvent>(messageFetchEvent);
    on<MessagePusherExistingChatsEvent>(messagePusherExistingChatsEvent);
    on<MessageNavigateToChatEvent>(messageNavigateToChatEvent);
    on<MessagePusherChatEvent>(messagePusherChatEvent);
    on<MessagePusherEventData>(messagePusherEventData);
    on<MessageSendEvent>(messageSendEvent);
  }

  FutureOr<void> messageEvent(MessageEvent event, Emitter<MessageState> emit) {}

  FutureOr<void> messageFetchEvent(
      MessageFetchEvent event, Emitter<MessageState> emit) async {
    emit(MessageExisitingChatsFetchLoadingState());
    try {
      final int id;
      final String token = await messengerRepository.getToken();
      final List<ExistingChat> existingChats =
          await messengerRepository.getExistingChats(token);
      if (event.role == 'Employee') {
        final data = await EmployeeStorage.getData();
        id = int.parse(data['user_id']!);
      } else {
        final data = await StudentStorage.getData();
        id = int.parse(data['user_id']!);
      }
      emit(MessageExisitingChatsFetchSuccessState(
          existingChats: existingChats, currentUserId: id));
    } catch (e) {
      emit(MessageExisitingChatsFetchFailedState(
          errorMessage: 'Message state: $e'));
    }
  }

  FutureOr<void> messagePusherExistingChatsEvent(
      MessagePusherExistingChatsEvent event, Emitter<MessageState> emit) async {
    await getExistingChats(event, emit);
  }

  FutureOr<void> messageNavigateToChatEvent(
      MessageNavigateToChatEvent event, Emitter<MessageState> emit) async {
    emit(MessageNavigatetoChatState(
        targetUserId: event.targetUserId,
        name: event.name,
        profile: event.profile,
        schoolId: event.schoolId));
    emit(MessageFetchLoadingChatState());
    try {
      final int currentUserId;
      await Future.delayed(const Duration(seconds: 3));
      final String token = await messengerRepository.getToken();

      if (event.role == 'Employee') {
        final data = await EmployeeStorage.getData();
        currentUserId = int.parse(data['user_id']!);
      } else {
        final data = await StudentStorage.getData();
        currentUserId = int.parse(data['user_id']!);
      }

      final List<Message> chats =
          await messengerRepository.getChats(token, event.targetUserId);

      emit(MessageFetchSuccessChatState(chats, currentUserId));

      log('success');
    } catch (e) {
      log('failed');
      emit(MessageFetchFailedChatState(errorMessage: '$e'));
    }
  }

  FutureOr<void> messagePusherChatEvent(
      MessagePusherChatEvent event, Emitter<MessageState> emit) async {
    try {
      log('loop');
      final int currentUserId;
      final String token = await messengerRepository.getToken();

      if (event.role == 'Employee') {
        final data = await EmployeeStorage.getData();
        currentUserId = int.parse(data['user_id']!);
      } else {
        final data = await StudentStorage.getData();
        currentUserId = int.parse(data['user_id']!);
      }

      final List<Message> chats =
          await messengerRepository.getChats(token, event.targetUserId);

      emit(MessageFetchSuccessChatState(chats, currentUserId));

      log('success');
    } catch (e) {
      log('failed');
      emit(MessageFetchFailedChatState(errorMessage: '$e'));
    }
  }

  FutureOr<void> messagePusherEventData(
      MessagePusherEventData event, Emitter<MessageState> emit) async {
    var currentState = state;
    if (currentState.runtimeType == MessageFetchSuccessChatState) {
      currentState as MessageFetchSuccessChatState;
      log('pumasok uli');
      log('ako si  ${event.data?.data}');
      final Map<String, dynamic> jsonMessage = jsonDecode(event.data?.data);
      log(jsonMessage['message']);
      final Message message = Message.fromMap(jsonMessage);

      final List<Message> updatedChats = [...currentState.chats];

      updatedChats.add(message);

      // emit the existing chats state
      await getExistingChats(event, emit);

      emit(MessageFetchSuccessChatState(
          updatedChats, currentState.currentUserId));
    }
  }

  Future<void> getExistingChats(
      dynamic event, Emitter<MessageState> emit) async {
    try {
      final int id;
      final String token = await messengerRepository.getToken();
      final List<ExistingChat> existingChats =
          await messengerRepository.getExistingChats(token);
      if (event.role == 'Employee') {
        final data = await EmployeeStorage.getData();
        id = int.parse(data['user_id']!);
      } else {
        final data = await StudentStorage.getData();
        id = int.parse(data['user_id']!);
      }
      emit(MessageExisitingChatsFetchSuccessState(
          existingChats: existingChats, currentUserId: id));
    } catch (e) {
      emit(MessageExisitingChatsFetchFailedState(
          errorMessage: 'Message state: $e'));
    }
  }

  FutureOr<void> messageSendEvent(
      MessageSendEvent event, Emitter<MessageState> emit) async {
    try {
      final String token = await messengerRepository.getToken();
      final message = await messengerRepository.sendMessage(
          token, event.targetUserId, event.message);
      var currentState = state;

      if (currentState is MessageFetchSuccessChatState) {
        final List<Message> updatedChats = [...currentState.chats];
        updatedChats.add(message);

        // emit the existing chats state
        await getExistingChats(event, emit);

        emit(MessageFetchSuccessChatState(
            updatedChats, currentState.currentUserId));
      }
    } catch (e) {
      log('the error in sending message is: ${e.toString()}');
      log('error');
    }
  }
}
