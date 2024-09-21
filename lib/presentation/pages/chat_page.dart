import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/presentation/bloc/message/message_bloc.dart';

class ChatPage extends StatefulWidget {
  final String role;
  final int targetUserId;

  const ChatPage({
    super.key,
    required this.role,
    required this.targetUserId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final TextEditingController textEditingController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    bool isDisabled = false;

    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<MessageBloc, MessageState>(
            listenWhen: (previous, current) =>
                current is MessageFetchSuccessChatState ||
                current is MessageFetchFailedChatState,
            listener: (context, state) {
              if (state is MessageFetchSuccessChatState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (scrollController.hasClients) {
                    scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn);
                  }
                });
              }
              if (state is MessageFetchFailedChatState) {
                // TO DO add scaffold.
              }
            },
            buildWhen: (previous, current) =>
                current is MessageFetchLoadingChatState ||
                current is MessageFetchSuccessChatState,
            builder: (context, state) {
              switch (state.runtimeType) {
                case MessageFetchLoadingChatState:
                  print('loading page');
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case MessageFetchSuccessChatState:
                  print('success page');
                  state as MessageFetchSuccessChatState;

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: scrollController,
                          itemCount: state.chats.length,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: state.currentUserId ==
                                      state.chats[index].sender_id
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Text(
                                  '${state.chats[index].message} ${state.chats[index].created_at}'),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {}
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your message';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      fillColor: Colors.grey[100],
                                      filled: true,
                                      hintText: 'Send Message',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                      prefixIcon: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                              Icons.emoji_emotions_outlined))),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                final validated =
                                    _formKey.currentState!.validate();

                                if (validated) {
                                  context.read<MessageBloc>().add(
                                      MessageSendEvent(
                                          role: widget.role,
                                          message: textEditingController.text,
                                          targetUserId: widget.targetUserId));

                                  textEditingController.clear();
                                }
                              },
                              icon: Icon(Icons.send),
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.grey[100]),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                default:
                  print('default page');
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              }
            }));
  }
}
