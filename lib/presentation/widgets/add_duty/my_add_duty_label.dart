import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAddDutiesLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final FontWeight? fontWeight;
  const MyAddDutiesLabel({
    super.key,
    required this.icon,
    required this.label,
    this.fontWeight
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          icon,
          color: const Color(0xFF6BB577),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: fontWeight,
            color: const Color(0xFF3B3B3B)
          ),
        )
      ],
    );
  }
}