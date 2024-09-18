import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/message/existing_chat.dart';
import 'package:help_isko/models/message/user.dart';
import 'package:help_isko/repositories/message_repositories.dart';
import 'package:help_isko/repositories/storage/employee_storage.dart';
import 'package:help_isko/repositories/storage/student_storage.dart';
import 'package:help_isko/services/message_service.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;
  MessageBloc({required this.messageRepository}) : super(MessageInitial()) {
    on<MessageEvent>(messageEvent);
    on<MessageFetchEvent>(messageFetchEvent);
    on<MessagePusherExistingChatsEvent>(messagePusherExistingChatsEvent);
  }

  FutureOr<void> messageEvent(MessageEvent event, Emitter<MessageState> emit) {}

  FutureOr<void> messageFetchEvent(
      MessageFetchEvent event, Emitter<MessageState> emit) async {
    emit(MessageExisitingChatsFetchLoadingState());
    try {
      final int id;
      final String token = await messageRepository.getToken();
      final List<ExistingChat> existingChats =
          await messageRepository.getExistingChats(token);
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
      print('Message state: $e');
    }
  }

  FutureOr<void> messagePusherExistingChatsEvent(
      MessagePusherExistingChatsEvent event, Emitter<MessageState> emit) async {
    try {
      final int id;
      final String token = await messageRepository.getToken();
      final List<ExistingChat> existingChats =
          await messageRepository.getExistingChats(token);
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
}
