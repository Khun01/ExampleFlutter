import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/models/duty/request_for_duties_student.dart';
import 'package:help_isko/presentation/widgets/studentDutyHours/my_duty_hours.dart';
import 'package:ionicons/ionicons.dart';

class AboutStudent extends StatelessWidget {
  final RequestForDutiesStudent requestForDutiesStudent;
  const AboutStudent({super.key, required this.requestForDutiesStudent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: const Color(0xFFA3D9A5),
                child: requestForDutiesStudent.profile != ''
                    ? Image.network(
                        '//${requestForDutiesStudent.profile}',
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error_rounded),
                      )
                    : Image.asset(
                        'assets/images/profile_clicked.png',
                        fit: BoxFit.cover,
                        width: 32,
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
                            requestForDutiesStudent.name,
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B)),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              log('The message button is clicked');
                            },
                            child: const Icon(
                              Ionicons.chatbubble_ellipses_outline,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        requestForDutiesStudent.studentNumber,
                        style: GoogleFonts.nunito(
                            fontSize: 12, color: const Color(0xFF3B3B3B)),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: List.generate(5, (index) {
                        return const Icon(
                          Ionicons.star_outline,
                          color: Colors.amber,
                          size: 15,
                        );
                      }),
                    ),
                    Expanded(child: MyDutyHours())
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
