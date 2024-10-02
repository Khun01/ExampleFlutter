import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentActivityCard extends StatelessWidget {
  final String title;
  final String description;
  final String message;
  final String date;
  const RecentActivityCard(
      {super.key,
      required this.title,
      required this.description,
      required this.message,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFFA3D9A5),
            child: title == 'Created'
                ? Image.asset('assets/images/duty_dialog_images/checked.png')
                : title == 'Deleted'
                    ? Image.asset('assets/images/duty_dialog_images/delete.png')
                    : title == 'Updated'
                        ? Image.asset(
                            'assets/images/duty_dialog_images/edit.png')
                        : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      description,
                      style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B)),
                    ),
                    const Spacer(),
                    Text(
                      date,
                      style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0x803B3B3B)),
                    )
                  ],
                ),
                Text(
                  message,
                  style: GoogleFonts.nunito(
                      fontSize: 12, color: const Color(0x803B3B3B)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
