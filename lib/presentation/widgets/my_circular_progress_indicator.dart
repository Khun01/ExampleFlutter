import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  const MyCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFCFCFC)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 24),
            Text(
              'Processing ...',
              style: GoogleFonts.nunito(
                fontSize: 14,
                color: const Color(0xFF3B3B3B)
              ),
            )
          ],
        ),
      ),
    );
  }
}