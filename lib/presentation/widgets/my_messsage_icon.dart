import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class MyMesssageIcon extends StatefulWidget {
  final int selectedIndex;
  const MyMesssageIcon({super.key, required this.selectedIndex});

  @override
  State<MyMesssageIcon> createState() => _MyMesssageIconState();
}

class _MyMesssageIconState extends State<MyMesssageIcon> {
  int number = 10;
  @override
  Widget build(BuildContext context) {
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
          child: number == 0 || widget.selectedIndex == 2
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
                      number.toString(),
                      style: GoogleFonts.nunito(
                        fontSize: 8,
                        color: const Color(0xFFFCFCFC)
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
