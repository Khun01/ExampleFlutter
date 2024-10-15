import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:ionicons/ionicons.dart';

class MyMesssageIcon extends StatefulWidget {
  final int selectedIndex;

  const MyMesssageIcon({
    super.key,
    required this.selectedIndex,
  });

  @override
  State<MyMesssageIcon> createState() => _MyMesssageIconState();
}

class _MyMesssageIconState extends State<MyMesssageIcon> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageBloc, MessageState>(
      listener: (context, state) {},
      builder: (context, state) {
        int unreadCount = 0;
        if(state is MessageExisitingChatsFetchSuccessState){
          unreadCount = state.existingChats.fold(0, (sum, chat) => sum + (chat.unreadMessagesCount ?? 0));
        }
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              widget.selectedIndex == 2
                  ? Ionicons.chatbubble_ellipses
                  : Ionicons.chatbubble_ellipses_outline,
              color: widget.selectedIndex == 2
                  ? const Color(0xFF6BB577)
                  : const Color(0xFF3B3B3B),
            ),
            Positioned(
              right: -4,
              top: -4,
              child: unreadCount == 0 || widget.selectedIndex == 2
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Center(
                        child: Text(
                          unreadCount.toString(),
                          style: GoogleFonts.nunito(
                            fontSize: 8,
                            color: const Color(0xFFFCFCFC),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
