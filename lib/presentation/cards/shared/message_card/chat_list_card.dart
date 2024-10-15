import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:help_isko/presentation/pages/conversation_page.dart';
import 'package:help_isko/presentation/pages/messenger_page.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/repositories/pusher_repository.dart';

class ChatListCard extends StatefulWidget {
  final String role;
  final int targetUserId;
  const ChatListCard(
      {super.key, required this.role, required this.targetUserId});

  @override
  State<ChatListCard> createState() => _ChatListCardState();
}

class _ChatListCardState extends State<ChatListCard> {
  late PusherRepository pusherRepository;

  @override
  void initState() {
    pusherRepository = PusherRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageBloc, MessageState>(
      listenWhen: (previous, current) =>
          current is MessageExisitingChatsFetchFailedState ||
          current is MessageExisitingChatsFetchSuccessState ||
          current is MessageExisitingChatsFetchLoadingState ||
          current is MessageNavigatetoChatState ||
          current is MessageDisposeState,
      listener: (context, state) {
        pusherRepository.listenEvents((e) {
          if (mounted) {
            if (state is MessageExisitingChatsFetchSuccessState) {
              context
                  .read<MessageBloc>()
                  .add(MessagePusherExistingChatsEvent(role: widget.role));
            }

            if (MessengerPage.listen) {
              context
                  .read<MessageBloc>()
                  .add(MessagePusherEventData(data: e, role: widget.role));
            }
          }
        });

        if (state is MessageExisitingChatsFetchFailedState) {
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text(state.errorMessage),
          // ));
          log('The error in message is: ${state.errorMessage}');
        }
        if (state is MessageNavigatetoChatState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<MessageBloc>(),
                child: ConversationPage(
                  role: widget.role,
                  targetUserId: state.targetUserId,
                  name: state.name,
                  profile: state.profile,
                  schoolId: state.schoolId,
                ),
              ),
            ),
          ).then((_) {
            // ignore: use_build_context_synchronously
            context
                .read<MessageBloc>()
                .add(MessageFetchEvent(role: widget.role));
          });
        }
      },
      buildWhen: (previous, current) =>
          current is MessageExisitingChatsFetchLoadingState ||
          current is MessageExisitingChatsFetchSuccessState ||
          current is MessageExisitingChatsFetchFailedState,
      builder: (context, state) {
        if (state is MessageExisitingChatsFetchLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MessageExisitingChatsFetchSuccessState) {
          if (state.existingChats.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/empty_chats.png'),
                  const SizedBox(height: 12),
                  Text(
                    'Currently, there are no chats available. Start a new conversation to see your chats here.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        fontSize: 16, color: const Color(0xFF3B3B3B)),
                  )
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: state.existingChats.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.read<MessageBloc>().add(MessageNavigateToChatEvent(
                        role: widget.role,
                        targetUserId: state.existingChats[index].user.id,
                        name: state.existingChats[index].user.name,
                        schoolId:
                            state.existingChats[index].user.schoolId ?? '',
                        profile:
                            state.existingChats[index].user.profileImage!));
                    MessengerPage.listen = true;
                    MessengerPage.targetUserId =
                        state.existingChats[index].user.id;
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 12, left: 16, right: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFA3D9A5),
                                  borderRadius: BorderRadius.circular(500)),
                              child: ClipOval(
                                child: state.existingChats[index].user
                                            .profileImage !=
                                        ''
                                    ? Image.network(
                                        '$profileUrl${state.existingChats[index].user.profileImage}',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                          margin: const EdgeInsets.all(12),
                                          child: Image.asset(
                                            'assets/images/profile_clicked.png',
                                          ),
                                        ),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.all(12),
                                        child: Image.asset(
                                          'assets/images/profile_clicked.png',
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.existingChats[index].user.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF3B3B3B)),
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          state.existingChats[index].message
                                                      .sender_id ==
                                                  state.currentUserId
                                              ? 'You: ${state.existingChats[index].message.message}'
                                              : state.existingChats[index]
                                                  .message.message,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.nunito(
                                            fontSize: 12,
                                            fontWeight: state
                                                            .existingChats[
                                                                index]
                                                            .message
                                                            .readStatus ==
                                                        1 ||
                                                    state.currentUserId !=
                                                        state
                                                            .existingChats[
                                                                index]
                                                            .message
                                                            .receiver_id
                                                ? FontWeight.normal
                                                : FontWeight.bold,
                                            color: state
                                                            .existingChats[
                                                                index]
                                                            .message
                                                            .readStatus ==
                                                        1 ||
                                                    state.currentUserId !=
                                                        state
                                                            .existingChats[
                                                                index]
                                                            .message
                                                            .receiver_id
                                                ? const Color(0xCC3B3B3B)
                                                : const Color(0xFF3B3B3B),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        state.existingChats[index].message
                                            .created_at,
                                        style: GoogleFonts.nunito(
                                            fontSize: 12,
                                            color: const Color(0xCC3B3B3B)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: const Color(0x1A3B3B3B),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
