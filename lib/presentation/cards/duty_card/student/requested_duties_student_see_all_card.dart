import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/student/homepage/requested_duties/requested_duties_bloc.dart';
import 'package:help_isko/repositories/global.dart';

class RequestedDutiesStudentSeeAllCard extends StatelessWidget {
  final int? id;
  final String profile;
  final String employeeName;
  final String date;
  final String building;
  final String message;
  final String? dutyStatus;
  final String? requestStatus;
  final String time;
  const RequestedDutiesStudentSeeAllCard({
    super.key,
    this.id,
    required this.profile,
    required this.employeeName,
    required this.date,
    required this.building,
    required this.message,
    this.dutyStatus,
    required this.time,
    this.requestStatus,
  });

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
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: const Color(0xFFA3D9A5),
                      borderRadius: BorderRadius.circular(500)),
                  child: ClipOval(
                    child: profile != ''
                        ? Image.network(
                            '$profileUrl$profile',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                    margin: const EdgeInsets.all(12),
                                    child: const Icon(Icons.person, size: 10)),
                          )
                        : Image.asset(
                            'assets/images/profile_clicked.png',
                            width: 5,
                            height: 5,
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 190,
                        child: Text(
                          employeeName,
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
                          Expanded(
                            child: Text(
                              'Date: $date',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                  fontSize: 10, color: const Color(0xCC3B3B3B)),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '$building - $time',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                  fontSize: 10, color: const Color(0xCC3B3B3B)),
                            ),
                          ),
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
            child: GestureDetector(
              onTap: () {
                if (requestStatus == 'undecided' && dutyStatus == 'pending') {
                  log('The request status is: $requestStatus, $dutyStatus');
                  context
                      .read<RequestedDutiesBloc>()
                      .add(RequestedDutyCancelEvent(id: id!));
                }
              },
              child: Container(
                width: 75,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: dutyStatus == 'pending' && requestStatus != 'undecided'
                      ? const Color(0xFFE5BA03)
                      : dutyStatus == 'active' && requestStatus != 'accepted'
                          ? const Color(0xFF6BB577)
                          : dutyStatus == 'ongoing' &&
                                  requestStatus != 'accepted'
                              ? const Color(0xFF26A1F4)
                              : dutyStatus == 'cancelled'
                                  ? const Color(0xFFF44336)
                                  : dutyStatus == 'pending' &&
                                          requestStatus == 'undecided'
                                      ? const Color(0xFFF44336)
                                      : dutyStatus == 'active' &&
                                              requestStatus == 'accepted'
                                          ? const Color(0xFF6BB577)
                                          : dutyStatus == 'ongoing' &&
                                                  requestStatus == 'accepted'
                                              ? const Color(0xFF26A1F4)
                                              : const Color(0xFFB2AC88),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(18)),
                ),
                child: Center(
                  child: Text(
                    dutyStatus == 'pending' && requestStatus != 'undecided'
                        ? 'Pending'
                        : dutyStatus == 'active' && requestStatus != 'accepted'
                            ? 'Active'
                            : dutyStatus == 'ongoing' &&
                                    requestStatus != 'accepted'
                                ? 'On-going'
                                : dutyStatus == 'cancelled'
                                    ? 'Cancelled'
                                    : dutyStatus == 'pending' &&
                                            requestStatus == 'undecided'
                                        ? 'Cancel'
                                        : dutyStatus == 'active' &&
                                                requestStatus == 'accepted'
                                            ? 'Active'
                                            : dutyStatus == 'ongoing' &&
                                                    requestStatus == 'accepted'
                                                ? 'On-going'
                                                : 'Completed',
                    style: GoogleFonts.nunito(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFCFCFC),
                    ),
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
