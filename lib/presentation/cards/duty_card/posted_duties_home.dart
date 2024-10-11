import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/requestForDuties/showRequestForDuties/request_for_duties_bloc.dart';
import 'package:help_isko/presentation/bloc/student/homepage/requested_duties/requested_duties_bloc.dart';
import 'package:help_isko/repositories/global.dart';

class PostedDutiesHome extends StatelessWidget {
  final int? id;
  final String date;
  final String building;
  final String message;
  final String dutyStatus;
  final String? requestStatus;
  final String? profile;

  const PostedDutiesHome(
      {super.key,
      required this.date,
      required this.building,
      required this.message,
      required this.dutyStatus,
      this.profile,
      this.id,
      this.requestStatus});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestForDutiesBloc, RequestForDutiesState>(
      listener: (context, state) {},
      builder: (context, state) {
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
                  Container(
                    height: 50,
                    width: 50,
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
                                child: const ImageIcon(
                                  AssetImage(
                                      'assets/images/profile_clicked.png'),
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.all(12),
                              child: const ImageIcon(
                                AssetImage('assets/images/profile_clicked.png'),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (requestStatus == 'undecided' &&
                                dutyStatus == 'pending') {
                              log('The request status is: $requestStatus, $dutyStatus');
                              context
                                  .read<RequestedDutiesBloc>()
                                  .add(RequestedDutyCancelEvent(id: id!));
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(18),
                                  bottomLeft: Radius.circular(18),
                                  bottomRight: Radius.circular(5)),
                              color: dutyStatus == 'pending' &&
                                      requestStatus != 'undecided'
                                  ? const Color(0xFFE5BA03)
                                  : dutyStatus == 'active' &&
                                          requestStatus != 'accepted'
                                      ? const Color(0xFF6BB577)
                                      : dutyStatus == 'ongoing' &&
                                              requestStatus != 'accepted'
                                          ? const Color(0xFF26A1F4)
                                          : dutyStatus == 'cancelled'
                                              ? const Color(0xFFF44336)
                                              : dutyStatus == 'pending' &&
                                                      requestStatus ==
                                                          'undecided'
                                                  ? const Color(0xFFF44336)
                                                  : dutyStatus == 'active' &&
                                                          requestStatus ==
                                                              'accepted'
                                                      ? const Color(0xFF6BB577)
                                                      : dutyStatus ==
                                                                  'ongoing' &&
                                                              requestStatus ==
                                                                  'accepted'
                                                          ? const Color(
                                                              0xFF26A1F4)
                                                          : const Color(
                                                              0xFFB2AC88),
                            ),
                            child: Center(
                              child: Text(
                                dutyStatus == 'pending' &&
                                        requestStatus != 'undecided'
                                    ? 'Pending'
                                    : dutyStatus == 'active' &&
                                            requestStatus != 'accepted'
                                        ? 'Active'
                                        : dutyStatus == 'ongoing' &&
                                                requestStatus != 'accepted'
                                            ? 'On-going'
                                            : dutyStatus == 'cancelled'
                                                ? 'Cancelled'
                                                : dutyStatus == 'pending' &&
                                                        requestStatus ==
                                                            'undecided'
                                                    ? 'Cancel'
                                                    : dutyStatus == 'active' &&
                                                            requestStatus ==
                                                                'accepted'
                                                        ? 'Active'
                                                        : dutyStatus ==
                                                                    'ongoing' &&
                                                                requestStatus ==
                                                                    'accepted'
                                                            ? 'On-going'
                                                            : 'Completed',
                                style: GoogleFonts.nunito(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFCFCFC)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
      },
    );
  }
}
