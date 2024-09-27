import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:help_isko/presentation/pages/conversation_page.dart';
import 'package:help_isko/presentation/pages/messenger_page.dart';
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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
          ));
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
          );
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
                            state.existingChats[index].user.school_id ?? '',
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
                            CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xFFA3D9A5),
                                child: state.existingChats[index].user
                                            .profileImage !=
                                        ''
                                    ? Image.network(
                                        '//${state.existingChats[index].user.profileImage}',
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.error_rounded),
                                      )
                                    : Image.asset(
                                        'assets/images/profile_clicked.png',
                                        fit: BoxFit.cover,
                                        width: 30,
                                      )),
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
                                              color: const Color(0xCC3B3B3B)),
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
