import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostedDutiesHome extends StatelessWidget {
  final String date;
  final String building;
  final String message;
  final String dutyStatus;

  const PostedDutiesHome({
    super.key,
    required this.date,
    required this.building,
    required this.message,
    required this.dutyStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      margin: const EdgeInsets.only(bottom: 16, left: 8),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x1A3B3B3B)),
        color: const Color(0xFFFCFCFC),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0.0, 10.0),
              blurRadius: 10.0,
              spreadRadius: -6.0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: Color(0x808CC9A6),
                radius: 25,
                child: ImageIcon(
                  AssetImage('assets/images/profile_clicked.png'),
                  size: 20,
                  color: Color(0xFF3B3B3B),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(18),
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(5)),
                          color: dutyStatus == 'pending'
                              ? const Color(0xFFE5BA03)
                              : dutyStatus == 'active'
                                  ? const Color(0xFF6BB577)
                                  : dutyStatus == 'on-going'
                                      ? const Color(0xFF26A1F4)
                                      : const Color(0xFFB2AC88)),
                      child: Center(
                        child: Text(
                          dutyStatus == 'pending'
                              ? 'Pending'
                              : dutyStatus == 'active'
                                  ? 'Active'
                                  : dutyStatus == 'on-going'
                                      ? 'On-going'
                                      : 'Completed',
                          style: GoogleFonts.nunito(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFCFCFC)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      date,
                      style: GoogleFonts.nunito(
                          fontSize: 8, color: const Color(0xCC3B3B3B)),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              building,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3B3B3B)),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: Text(
              message,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                  fontSize: 10, color: const Color(0xCC3B3B3B)),
            ),
          )
        ],
      ),
    );
  }
}
