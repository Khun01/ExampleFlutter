import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MyIconButtonAppBar extends StatefulWidget {
  final Color iconColor;
  final String selectedRole;

  const MyIconButtonAppBar({
    super.key,
    this.iconColor = const Color(0xFF3B3B3B),
    required this.selectedRole
  });

  @override
  State<MyIconButtonAppBar> createState() => _MyIconButtonAppBarState();
}

class _MyIconButtonAppBarState extends State<MyIconButtonAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          widget.selectedRole == 'Professor' ?
          Ionicons.reader_outline : Ionicons.document_outline,
          size: 25,
          color: widget.iconColor
        ),
        const SizedBox(width: 5),
        Icon(
          Ionicons.chatbubble_ellipses_outline,
          size: 25,
          color: widget.iconColor
        ),
        const SizedBox(width: 2.5),
        Icon(
          Ionicons.notifications_outline,
          size: 25,
          color: widget.iconColor
        ),
      ],
    );
  }
}