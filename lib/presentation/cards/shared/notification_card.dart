import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String date;
  const NotificationCard(
      {super.key,
      required this.title,
      required this.message,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFCFC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0x333B3B3B),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0.0, 10.0),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            child: title == 'Duty Active!'
                ? Image.asset('assets/images/notif/active_notif.png')
                : title == 'Duty Completed!' || title == 'Duty Accepted!'
                    ? Image.asset(
                        'assets/images/duty_dialog_images/checked.png')
                    : title == 'Duty Ongoing!'
                        ? Image.asset('assets/images/notif/ongoing_notif.png')
                        : title == 'Finished Duty!'
                            ? Image.asset(
                                'assets/images/notif/unfinished_notif.png')
                            : title == 'Someone commented about you!'
                                ? Image.asset(
                                    'assets/images/notif/commented_notif.png')
                                : title == 'Request Rejected' || title == 'Duty Cancelled!'
                                    ? Image.asset('assets/images/duty_dialog_images/delete.png')
                                    : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B3B3B)),
                ),
                Text(
                  '$message on $date ',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunito(
                      fontSize: 12, color: const Color(0xFF3B3B3B)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
