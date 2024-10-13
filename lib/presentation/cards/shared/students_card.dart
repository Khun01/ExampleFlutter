import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:ionicons/ionicons.dart';

class StudentsCard extends StatelessWidget {
  final String? profile;
  final String name;
  final String course;
  final String studentNumber;
  final int targetUserId;
  final int activeDutyCount;
  final int completedDutyCount;
  const StudentsCard({
    super.key,
    required this.name,
    required this.course,
    required this.profile,
    required this.studentNumber,
    required this.targetUserId,
    required this.activeDutyCount,
    required this.completedDutyCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFCFC),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0.0, 10.0),
              blurRadius: 10.0,
              spreadRadius: -6.0),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: const Color(0xFFA3D9A5),
                borderRadius: BorderRadius.circular(500)),
            child: profile != ''
                ? ClipOval(
                    child: Image.network(
                      '$profileUrl$profile',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        margin: const EdgeInsets.all(14),
                        child: Image.asset(
                          'assets/images/profile_clicked.png',
                        ),
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
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Row(
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3B3B3B)),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          log('The message button is clicked in student card');

                          context.read<MessageBloc>().add(
                              MessageNavigateToChatEvent(
                                  schoolId: studentNumber,
                                  role: 'Employee',
                                  targetUserId: targetUserId,
                                  name: name,
                                  profile: profile!));
                        },
                        child: const Icon(
                          Ionicons.chatbubble_ellipses_outline,
                          size: 16,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    course,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                        fontSize: 12, color: const Color(0xCC3B3B3B)),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: List.generate(5, (index) {
                    return const Icon(
                      Icons.star_outline,
                      color: Colors.amber,
                      size: 15,
                    );
                  }),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Active duty - $activeDutyCount',
                        style: GoogleFonts.nunito(
                            fontSize: 10, color: const Color(0xCC3B3B3B)),
                      ),
                      Text(
                        'Completed duty - $completedDutyCount',
                        style: GoogleFonts.nunito(
                            fontSize: 10, color: const Color(0xCC3B3B3B)),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
