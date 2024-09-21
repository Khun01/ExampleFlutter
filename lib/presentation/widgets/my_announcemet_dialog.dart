import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/models/data/announcement.dart';

class MyAnnouncemetDialog extends StatelessWidget {
  final Announcement announcement;
  const MyAnnouncemetDialog({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: const Color(0xFFAED8B5),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                announcement.announcementImg != null &&
                        announcement.announcementImg!.isNotEmpty
                    ? Image.network(announcement.announcementImg!)
                    : Image.asset(
                        'assets/images/upang_logo.png',
                        width: 60,
                      ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 208,
                      child: Text(
                        announcement.heading,
                        maxLines: 4,
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3B3B3B)),
                      ),
                    ),
                    SizedBox(
                      width: 75,
                      child: Text(
                        announcement.time,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: GoogleFonts.nunito(
                            fontSize: 12, color: const Color(0xFF3B3B3B)),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(
              announcement.description,
              style: GoogleFonts.nunito(
                  fontSize: 12, color: const Color(0xFF3B3B3B)),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Posted by: PHINMA University of Pangasinan',
                style: GoogleFonts.nunito(
                    fontSize: 12, color: const Color(0xFF3B3B3B)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
