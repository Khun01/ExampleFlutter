import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostedDutiesSeeAllCard extends StatelessWidget {
  final String date;
  final String building;
  final String message;
  final String dutyStatus;
  final String startTime;
  final String endTime;
  const PostedDutiesSeeAllCard(
      {super.key,
      required this.date,
      required this.building,
      required this.message,
      required this.dutyStatus,
      required this.startTime,
      required this.endTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFCFC),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0.0, 10.0),
              blurRadius: 10.0,
              spreadRadius: -6.0),
        ],
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFFA3D9A5),
                    child: Image.asset(
                      width: 30,
                      'assets/images/profile_clicked.png',
                      fit: BoxFit.cover,
                    )),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 190,
                        child: Text(
                          building,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        message,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                            fontSize: 10, color: const Color(0xCC3B3B3B)),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Date: $date',
                            style: GoogleFonts.nunito(
                                fontSize: 10, color: const Color(0xCC3B3B3B)),
                          ),
                          const Spacer(),
                          Text(
                            'Time: $startTime - $endTime',
                            style: GoogleFonts.nunito(
                                fontSize: 10, color: const Color(0xCC3B3B3B)),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              width: 75,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: dutyStatus == 'pending'
                      ? const Color(0xFFE5BA03)
                      : dutyStatus == 'active'
                          ? const Color(0xFF6BB577)
                          : dutyStatus == 'on-going'
                              ? const Color(0xFF26A1F4)
                              : const Color(0xFFB2AC88),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(18))),
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
          )
        ],
      ),
    );
  }
}
