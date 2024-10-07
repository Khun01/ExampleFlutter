import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/repositories/global.dart';

class ConversationListCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: isCurrentUser
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          offset: const Offset(0.0, 10.0),
                          blurRadius: 10.0,
                          spreadRadius: -6.0,
                        ),
                      ]),
            child: Container(
              height: isCurrentUser ? 0 : 40,
              width: isCurrentUser ? 0 : 40,
              decoration: BoxDecoration(
                color: const Color(0xFFD1D1D1),
                borderRadius: BorderRadius.circular(500)
              ),
              child: ClipOval(
                child: isCurrentUser
                    ? null
                    : profile != null
                        ? Image.network(
                            '$profileUrl$profile',
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              'assets/images/profile_clicked.png',
                              fit: BoxFit.cover,
                              width: 30,
                            ),
                          )
                        : Image.asset(
                            'assets/images/profile_clicked.png',
                            fit: BoxFit.cover,
                            width: 30,
                          ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: isCurrentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 12, right: 16, top: 16),
                  child: Text(
                    isCurrentUser ? '' : name,
                    style: GoogleFonts.nunito(
                        fontSize: 12, color: const Color(0xFF3B3B3B)),
                  )),
              Row(
                children: [
                  Text(
                    isCurrentUser ? createdAt : '',
                    style: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0x803B3B3B)),
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
                        color: isCurrentUser
                            ? const Color(0xFF6BB577)
                            : const Color(0xFFD1D1D1),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20),
                          bottomLeft: isCurrentUser
                              ? const Radius.circular(20)
                              : Radius.zero,
                          bottomRight: isCurrentUser
                              ? Radius.zero
                              : const Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                              offset: const Offset(0.0, 10.0),
                              blurRadius: 10.0,
                              spreadRadius: -6.0)
                        ]),
                    child: Text(
                      message,
                      maxLines: null,
                      style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isCurrentUser
                              ? const Color(0xFFFCFCFC)
                              : const Color(0xFF3B3B3B)),
                    ),
                  ),
                  Text(
                    isCurrentUser ? '' : createdAt,
                    style: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0x803B3B3B)),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
