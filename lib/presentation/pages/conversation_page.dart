import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:help_isko/presentation/cards/shared/message_card/conversation_list_card.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:ionicons/ionicons.dart';
import 'package:uicons/uicons.dart';

class ConversationPage extends StatefulWidget {
  final String role;
  final String name;
  final String profile;
  final int targetUserId;
  final String schoolId;

  const ConversationPage(
      {super.key,
      required this.role,
      required this.targetUserId,
      required this.name,
      required this.profile,
      required this.schoolId});

  @override
  State<ConversationPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ConversationPage> {
  late ScrollController _scrollController;
  final TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        log('The keyboard is open');
        Future.delayed(const Duration(milliseconds: 700), () {
          _scrollToBottom();
        });
      } else {
        log('The keyboard is remove');
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        double scrollFactor = Platform.isAndroid ? 2.5 : 1.5;
        final position =
            _scrollController.position.maxScrollExtent * scrollFactor;
        _scrollController.animateTo(position,
            duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      }
    });
  }

  Future<bool> _onBackPressed() async {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    focusNode.dispose();
    textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('building this widget');
    return BlocConsumer<MessageBloc, MessageState>(
      listenWhen: (previous, current) =>
          current is MessageFetchSuccessChatState ||
          current is MessageFetchFailedChatState,
      listener: (context, state) {
        if (state is MessageFetchSuccessChatState) {
          _scrollToBottom();
        }
        if (state is MessageFetchFailedChatState) {}
      },
      buildWhen: (previous, current) =>
          current is MessageFetchLoadingChatState ||
          current is MessageFetchSuccessChatState,
      builder: (context, state) {
        Widget body;

        switch (state.runtimeType) {
          case MessageFetchLoadingChatState:
            body = const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
            break;
          case MessageFetchSuccessChatState:
            final successState = state as MessageFetchSuccessChatState;
            if (successState.chats.isEmpty) {
              body = SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/no_chat.png'),
                        const SizedBox(height: 16),
                        Text(
                          'No Message, yet',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Send a message to get the conversation started and connect with them.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 14, color: const Color(0xCC3B3B3B)),
                        )
                      ],
                    ),
                  ));
            } else {
              body = SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final convo = successState.chats[index];
                    return ConversationListCard(
                      name: widget.name,
                      profile: widget.profile,
                      message: convo.message,
                      createdAt: convo.created_at,
                      isCurrentUser:
                          convo.sender_id == successState.currentUserId,
                    );
                  },
                  childCount: successState.chats.length,
                ),
              );
            }
            break;
          case MessageFetchFailedChatState:
            body = SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  'Network Error, Please try again later',
                  style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B),
                  ),
                ),
              ),
            );
            break;
          default:
            body = SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  'Unexpected State',
                  style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B),
                  ),
                ),
              ),
            );
            break;
        }
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () => _onBackPressed(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverLayoutBuilder(
                        builder: (context, constraints) {
                          final scrolled = constraints.scrollOffset > 0;
                          return SliverAppBar(
                            pinned: true,
                            automaticallyImplyLeading: false,
                            collapsedHeight: 70,
                            flexibleSpace: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                boxShadow: scrolled
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: const Offset(0.0, 10.0),
                                          blurRadius: 10.0,
                                          spreadRadius: -6.0,
                                        )
                                      ]
                                    : [],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0x1AA3D9A5),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                          Ionicons.chevron_back_outline),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFA3D9A5),
                                        borderRadius:
                                            BorderRadius.circular(500)),
                                    child: ClipOval(
                                      child: widget.profile != ''
                                          ? Image.network(
                                              '$profileUrl${widget.profile}',
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Container(
                                                margin:
                                                    const EdgeInsets.all(14),
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.name,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF3B3B3B),
                                        ),
                                      ),
                                      Text(
                                        widget.schoolId,
                                        style: GoogleFonts.nunito(
                                          fontSize: 12,
                                          color: const Color(0xFF3B3B3B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      body,
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCFCFC),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(0, -6),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  focusNode: focusNode,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your message';
                                    }
                                    return null;
                                  },
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    fillColor: const Color(0x1A3B3B3B),
                                    filled: true,
                                    hintText: 'Send Message',
                                    hintStyle: GoogleFonts.nunito(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0x803B3B3B),
                                    ),
                                    prefixIcon: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.emoji_emotions_outlined),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0x1A3B3B3B),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  final validated =
                                      _formKey.currentState!.validate();
                                  if (validated) {
                                    context.read<MessageBloc>().add(
                                          MessageSendEvent(
                                            role: widget.role,
                                            message: textEditingController.text,
                                            targetUserId: widget.targetUserId,
                                          ),
                                        );

                                    textEditingController.clear();
                                  }
                                },
                                child: Icon(
                                  UIcons.solidRounded.paper_plane,
                                  color: const Color(0xFF3B3B3B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
