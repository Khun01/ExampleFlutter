import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfilePageText extends StatelessWidget {
  final String? title1;
  final String? title2;
  final String? body1;
  final String? body2;
  const MyProfilePageText(
      {super.key, this.title1, this.title2, this.body1, this.body2});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title1 ?? 'N/A',
              style: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0x803B3B3B)),
            ),
            SizedBox(
              width: 138,
              child: Text(
                body1 ?? 'N/A',
                maxLines: 3,
                style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B)),
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title2 ?? '',
              style: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0x803B3B3B)),
            ),
            Text(
              body2 ?? '',
              style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3B3B3B)),
            ),
          ],
        )
      ],
    );
  }
}
