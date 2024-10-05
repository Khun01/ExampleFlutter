import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/widgets/studentDutyHours/my_custom_progress_bar.dart';

class MyDutyHours extends StatefulWidget {
  final int percentage;
  const MyDutyHours({super.key, required this.percentage});

  @override
  State<MyDutyHours> createState() => _DutyHoursState();
}

class _DutyHoursState extends State<MyDutyHours> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFCFCFC),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0.0, 10.0),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/check-mark.png',
            height: 50,
            width: 50,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Duty Hours',
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B),
                  ),
                ),
                const SizedBox(height: 3),
                MyCustomProgressBar(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 10,
                  progress: widget.percentage / 100,
                ),
                const SizedBox(height: 3),
                Text(
                  'Progress',
                  style: GoogleFonts.nunito(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: const Color(0x803B3B3B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}