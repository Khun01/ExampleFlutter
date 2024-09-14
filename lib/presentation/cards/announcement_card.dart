import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnouncementCard extends StatelessWidget {
  final String heading;
  final String description;
  final String? announcementImg;
  final String time;

  const AnnouncementCard(
      {super.key,
      required this.heading,
      required this.description,
      required this.announcementImg,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFA3D9A5),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0.0, 10.0),
              blurRadius: 10.0,
              spreadRadius: -6.0),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 90,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: announcementImg != null && announcementImg!.isNotEmpty
                    ? NetworkImage(announcementImg!)
                    : const AssetImage('assets/images/upang_logo.png')
                        as ImageProvider,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 170,
                      child: Text(
                        heading,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3B3B3B)),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 60,
                      child: Text(
                        time,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.nunito(
                          fontSize: 10,
                          color: const Color(0xCC3B3B3B),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunito(
                      fontSize: 10, color: const Color(0xCC3B3B3B)),
                ),
                const SizedBox(height: 5),
                Text(
                  'Posted by: PHINMA University of Pangasinan',
                  style: GoogleFonts.nunito(
                      fontSize: 10, color: const Color(0xCC3B3B3B)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
