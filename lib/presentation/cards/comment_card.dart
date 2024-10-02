import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

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
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFA3D9A5),
            child: profile != ''
                ? ClipOval(
                    child: Image.network(
                      'http://192.168.100.212:8000/$profile',
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error_rounded),
                    ),
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
                Row(
                  children: List.generate(5, (index) {
                    return const Icon(
                      Ionicons.star_outline,
                      color: Colors.amber,
                      size: 15,
                    );
                  }),
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
