import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:help_isko/presentation/cards/message_card/chat_list_card.dart';
import 'package:help_isko/repositories/messenger_repositories.dart';
import 'package:help_isko/services/messenger_service.dart';
import 'package:ionicons/ionicons.dart';

class MessengerPage extends StatefulWidget {
  final String role;
  static bool listen = false;
  static int targetUserId = 0;

  const MessengerPage({super.key, required this.role});

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MessageBloc(
              messengerRepository:
                  MessengerRepository(MessengerService(role: widget.role)))
            ..add(MessageFetchEvent(role: widget.role)),
        ),
      ],
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
                child: ChatListCard(
                    role: widget.role,
                    targetUserId: MessengerPage.targetUserId),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
