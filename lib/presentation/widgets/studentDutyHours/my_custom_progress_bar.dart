import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomProgressBar extends StatelessWidget {
  final double width;
  final double height;
  final double progress;

  const MyCustomProgressBar({
    super.key,
    required this.width,
    required this.height,
    required this.progress
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(50)
      ),
      child: Stack(
        children: [
          Container(
            width: width * progress,
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFF4ECB71),
              borderRadius: BorderRadius.circular(50)
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${progress*100.toInt()}%',
              style: GoogleFonts.nunito(
                fontSize: 8,
                color: const Color(0xCC3B3B3B),
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}