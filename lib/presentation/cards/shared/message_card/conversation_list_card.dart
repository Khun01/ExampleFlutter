import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/repositories/global.dart';

class ConversationListCard extends StatefulWidget {
  final String name;
  final String? profile;
  final String message;
  final String createdAt;
  final bool isCurrentUser;
  const ConversationListCard(
      {super.key,
      required this.message,
      required this.createdAt,
      required this.isCurrentUser,
      required this.name,
      required this.profile});

  @override
  State<ConversationListCard> createState() => _ConversationListCardState();
}

class _ConversationListCardState extends State<ConversationListCard> {
  bool _showTimestamp = false;

  void toggleTimestamp() {
    setState(() {
      _showTimestamp = !_showTimestamp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: widget.isCurrentUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: widget.isCurrentUser
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        offset: const Offset(0.0, 10.0),
                        blurRadius: 10.0,
                        spreadRadius: -6.0,
                      ),
                    ],
            ),
            child: Container(
              height: widget.isCurrentUser ? 0 : 40,
              width: widget.isCurrentUser ? 0 : 40,
              decoration: BoxDecoration(
                color: const Color(0xFFD1D1D1),
                borderRadius: BorderRadius.circular(500),
              ),
              child: ClipOval(
                child: widget.isCurrentUser
                    ? null
                    : widget.profile != null
                        ? Image.network(
                            '$profileUrl${widget.profile}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              margin: const EdgeInsets.all(12),
                              child: Image.asset(
                                'assets/images/profile_clicked.png',
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.all(14),
                            child: Image.asset(
                              'assets/images/profile_clicked.png',
                            ),
                          ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: widget.isCurrentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 12, right: 16, top: widget.isCurrentUser ? 2 : 16),
                child: Text(
                  widget.isCurrentUser ? '' : widget.name,
                  style: GoogleFonts.nunito(
                    fontSize: widget.isCurrentUser ? 0 : 12,
                    color: const Color(0xFF3B3B3B),
                  ),
                ),
              ),
              SizedBox(height: widget.isCurrentUser ? 0 : 2),
              GestureDetector(
                onTap: () {
                  toggleTimestamp();
                },
                child: Row(
                  children: [
                    AnimatedOpacity(
                      opacity: _showTimestamp ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: AnimatedSlide(
                        offset: _showTimestamp
                            ? Offset.zero
                            : const Offset(-0.5, 0),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Text(
                          widget.isCurrentUser ? widget.createdAt : '' ,
                          style: GoogleFonts.nunito(
                            fontSize: widget.isCurrentUser ? 10 : 0,
                            color: const Color(0xFF757575),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.60,
                      ),
                      decoration: BoxDecoration(
                        color: widget.isCurrentUser
                            ? const Color(0xFF6BB577)
                            : const Color(0xFFD1D1D1),
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20),
                            bottomLeft: widget.isCurrentUser
                                ? const Radius.circular(20)
                                : Radius.zero,
                            bottomRight: const Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            offset: const Offset(0.0, 10.0),
                            blurRadius: 10.0,
                            spreadRadius: -6.0,
                          )
                        ],
                      ),
                      child: Text(
                        widget.message,
                        maxLines: null,
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: widget.isCurrentUser
                              ? const Color(0xFFFCFCFC)
                              : const Color(0xFF3B3B3B),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _showTimestamp ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: AnimatedSlide(
                        offset: _showTimestamp
                            ? Offset.zero
                            : const Offset(0.5, 0),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Text(
                          widget.isCurrentUser ? '' : widget.createdAt,
                          style: GoogleFonts.nunito(
                            fontSize: widget.isCurrentUser ? 0 : 10,
                            color: const Color(0xFF757575),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
