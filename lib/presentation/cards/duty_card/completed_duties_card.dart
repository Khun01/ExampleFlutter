import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uicons/uicons.dart';

class CompletedDutiesCard extends StatelessWidget {
  final String building;
  final String message;
  final String dutyStatus;
  const CompletedDutiesCard(
      {super.key,
      required this.building,
      required this.message,
      required this.dutyStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Stack(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0x1AA3D9A5),
                child: Icon(
                  UIcons.regularRounded.building,
                  size: 32,
                  color: const Color(0xFF3B3B3B),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      building,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                    Text(
                      message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        color: const Color(0xFF3B3B3B),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              width: 75,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFFB2AC88),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(18),
                  topLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(18),
                ),
              ),
              child: Center(
                child: Text(
                  dutyStatus == 'completed' ? 'Completed' : 'Error',
                  style: GoogleFonts.nunito(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFCFCFC)
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
