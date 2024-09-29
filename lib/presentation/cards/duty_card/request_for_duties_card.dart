import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/requestForDuties/acceptStudent/accept_student_bloc.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';
import 'package:ionicons/ionicons.dart';

class RequestForDutiesCard extends StatelessWidget {
  final int? dutyId;
  final String profile;
  final String name;
  final String building;
  final String startTime;
  final String endTime;
  final String date;
  final String message;
  final int? studentId;
  const RequestForDutiesCard(
      {super.key,
      this.dutyId,
      required this.profile,
      required this.name,
      required this.building,
      required this.startTime,
      required this.endTime,
      required this.date,
      required this.message,
      this.studentId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcceptStudentBloc, AcceptStudentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: const Color(0xFFFCFCFC),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0x1A3B3B3B)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  offset: const Offset(0.0, 10.0),
                  blurRadius: 10.0,
                  spreadRadius: -6.0,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xFFA3D9A5),
                      child: profile != ''
                          ? Image.network(
                              '//$profile',
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error_rounded),
                            )
                          : Image.asset(
                              'assets/images/profile_clicked.png',
                              fit: BoxFit.cover,
                              width: 30,
                            )),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                name,
                                style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B)),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                log('The message button is clicked');
                              },
                              child: const Icon(
                                Ionicons.chatbubble_ellipses_outline,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return const Icon(
                              Ionicons.star_outline,
                              color: Colors.amber,
                              size: 15,
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Where:',
                          style: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0x803B3B3B)),
                        ),
                        Text(
                          building,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        ),
                        Text(
                          '$startTime - $endTime',
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'When:',
                          style: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0x803B3B3B)),
                        ),
                        Text(
                          date,
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  message,
                  style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xCC3B3B3B)),
                ),
              ),
              const SizedBox(height: 4),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: MyButton(
                          onTap: () {
                            log('The decline button is clicked');
                          },
                          buttonText: 'Decline',
                          color: const Color(0xFFF44336))),
                  const SizedBox(width: 8),
                  Expanded(
                      child: MyButton(
                          onTap: () {
                            context.read<AcceptStudentBloc>().add(AcceptStudentButtonClickedEvent(dutyId: dutyId!, studentId: studentId!));
                          },
                          buttonText: 'Accept'))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
