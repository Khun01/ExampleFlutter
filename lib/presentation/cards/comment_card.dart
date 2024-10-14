import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/repositories/global.dart';

class CommentCard extends StatelessWidget {
  final String comment;
  final String firstName;
  final String lastName;
  final String time;
  final String? profile;
  const CommentCard(
      {super.key,
      required this.comment,
      required this.firstName,
      required this.lastName,
      this.profile,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                Row(
                  children: [
                    Text(
                      firstName,
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      lastName,
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      time,
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        color: const Color(0xCC3B3B3B),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    comment,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      color: const Color(0x803B3B3B),
                    ),
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
