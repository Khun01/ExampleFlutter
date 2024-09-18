import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/message/message_bloc.dart';
import 'package:help_isko/repositories/message_repositories.dart';
import 'package:help_isko/repositories/pusher_repository.dart';
import 'package:help_isko/services/message_service.dart';
import 'package:ionicons/ionicons.dart';

class MessengerPage extends StatelessWidget {
  final String role;
  const MessengerPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageBloc(
          messageRepository: MessageRepository(MessageService(role: role)))
        ..add(MessageFetchEvent(role: role)),
      child: Scaffold(
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            SliverLayoutBuilder(
              builder: (context, constraints) {
                final scrolled = constraints.scrollOffset > 0;
                return SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: scrolled
                            ? [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: const Offset(0.0, 10.0),
                                    blurRadius: 10.0,
                                    spreadRadius: -6.0)
                              ]
                            : []),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              'Message',
                              style: GoogleFonts.nunito(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)),
                            ),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  log('The search button is clicked');
                                },
                                child: const Icon(Ionicons.search))
                          ],
                        )),
                  ),
                );
              },
            ),
            SliverFillRemaining(
              child: BlocConsumer<MessageBloc, MessageState>(
                listenWhen: (previous, current) =>
                    current is MessageExisitingChatsFetchFailedState ||
                    current is MessageExisitingChatsFetchSuccessState ||
                    current is MessageExisitingChatsFetchLoadingState,
                listener: (context, state) {
                  PusherRepository()
                    ..listenEvents((e) {
                      context
                          .read<MessageBloc>()
                          .add(MessagePusherExistingChatsEvent(role: role));
                    });
                  if (state is MessageExisitingChatsFetchFailedState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.errorMessage),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                buildWhen: (previous, current) =>
                    current is MessageExisitingChatsFetchLoadingState ||
                    current is MessageExisitingChatsFetchSuccessState ||
                    current is MessageExisitingChatsFetchFailedState,
                builder: (context, state) {
                  print('Message page');
                  switch (state.runtimeType) {
                    case MessageExisitingChatsFetchLoadingState:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case MessageExisitingChatsFetchSuccessState:
                      state as MessageExisitingChatsFetchSuccessState;

                      return ListView.builder(
                        itemCount: state.existingChats.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Container(
                              height: 70,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: state.existingChats[index].user
                                                .profileImage !=
                                            ''
                                        ? Image.network(
                                            '${state.existingChats[index].user.profileImage}',
                                            height: 70,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Icon(Icons.error_rounded),
                                          )
                                        : Image.asset(
                                            'assets/images/luffy.jpeg',
                                            height: 70,
                                          ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state.existingChats[index]
                                                          .user.name,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 24,
                                                      ),
                                                    ),
                                                    Text(
                                                      state
                                                                  .existingChats[
                                                                      index]
                                                                  .message
                                                                  .sender_id ==
                                                              state
                                                                  .currentUserId
                                                          ? 'You: ${state.existingChats[index].message.message}'
                                                          : '${state.existingChats[index].user.name}: ${state.existingChats[index].message.message}',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[700]!,
                                                          fontSize: 13),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[300]!))),
                                        ),
                                        Positioned(
                                            right: -10,
                                            top: 26,
                                            child: Icon(Icons.more_vert)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // decoration: BoxDecoration(color: Colors.red),
                            ),
                          );
                        },
                      );

                    default:
                      return Container(
                        height: 1200,
                        decoration: const BoxDecoration(color: Colors.white),
                      );
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
