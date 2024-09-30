import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class StudentsCard extends StatelessWidget {
  final String profile;
  final String name;
  final String course;
  const StudentsCard(
      {super.key,
      required this.name,
      required this.course,
      required this.profile});

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
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFA3D9A5),
            child: profile != ''
                ? Image.network(
                    '//$profile',
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error_rounded),
                  )
                : Image.asset(
                    'assets/images/profile_clicked.png',
                    fit: BoxFit.cover,
                    width: 30,
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
                          log('The message button is clicked');
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
                        'Active duty - 1',
                        style: GoogleFonts.nunito(
                            fontSize: 10, color: const Color(0xCC3B3B3B)),
                      ),
                      Text(
                        'Pendgin duty - 1',
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
