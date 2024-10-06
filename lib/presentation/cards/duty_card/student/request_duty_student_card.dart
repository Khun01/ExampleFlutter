import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/student/dutiespage/duties_bloc.dart';
import 'package:help_isko/presentation/bloc/student/homepage/requested_duties/requested_duties_bloc.dart';
import 'package:help_isko/repositories/global.dart';

class RequestDutyStudentCard extends StatelessWidget {
  final String role;
  final int? id;
  final String profile;
  final String date;
  final String building;
  final String message;
  final String? dutyStatus;
  final String startTime;
  final String endTime;
  const RequestDutyStudentCard(
      {super.key,
      required this.role,
      this.id,
      required this.profile,
      required this.date,
      required this.building,
      required this.message,
      this.dutyStatus,
      required this.startTime,
      required this.endTime});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestedDutiesBloc, RequestedDutiesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<DutiesBloc, DutiesState>(
          listener: (context, state) {},
          builder: (context, state) {
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
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.person, size: 10),
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
                                    fontSize: 10,
                                    color: const Color(0xCC3B3B3B)),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'Date: $date',
                                    style: GoogleFonts.nunito(
                                        fontSize: 10,
                                        color: const Color(0xCC3B3B3B)),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Time: $startTime - $endTime',
                                    style: GoogleFonts.nunito(
                                        fontSize: 10,
                                        color: const Color(0xCC3B3B3B)),
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
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<DutiesBloc>()
                            .add(DutiesAcceptEvent(id: id!));
                      },
                      child: Container(
                        width: 75,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF6BB577),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18),
                              topLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(18)),
                        ),
                        child: Center(
                          child: Text(
                            'Accept',
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
          },
        );
      },
    );
  }
}