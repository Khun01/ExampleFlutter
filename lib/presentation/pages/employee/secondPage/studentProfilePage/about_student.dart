import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/models/duty/request_for_duties_student.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AboutStudent extends StatefulWidget {
  final RequestForDutiesStudent requestForDutiesStudent;
  final double percent;
  const AboutStudent(
      {super.key, required this.requestForDutiesStudent, this.percent = 84.4});

  @override
  State<AboutStudent> createState() => _AboutStudentState();
}

class _AboutStudentState extends State<AboutStudent>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<int> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation =
        IntTween(begin: 0, end: widget.percent.toInt()).animate(controller)
          ..addListener(() {
            setState(() {});
          });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xFFFCFCFC),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0x1A3B3B3B))),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: const Color(0xFFA3D9A5),
                      child: widget.requestForDutiesStudent.profile != ''
                          ? Image.network(
                              '//${widget.requestForDutiesStudent.profile}',
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error_rounded),
                            )
                          : Image.asset(
                              'assets/images/profile_clicked.png',
                              fit: BoxFit.cover,
                              width: 32,
                            ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Row(
                              children: [
                                Text(
                                  widget.requestForDutiesStudent.name,
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF3B3B3B)),
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
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              widget.requestForDutiesStudent.studentNumber,
                              style: GoogleFonts.nunito(
                                  fontSize: 12, color: const Color(0xCC3B3B3B)),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: List.generate(5, (index) {
                              return const Icon(
                                Ionicons.star_outline,
                                color: Colors.amber,
                                size: 15,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 110,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const BoxDecoration(
                              color: Color(0x1A6BB577),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(2),
                                  bottomRight: Radius.circular(2))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularPercentIndicator(
                                radius: 29,
                                lineWidth: 6,
                                backgroundColor: const Color(0xFFD9D9D9),
                                progressColor: const Color(0xFF6BB577),
                                animation: true,
                                animationDuration: 3000,
                                percent: widget.percent / 100,
                                circularStrokeCap: CircularStrokeCap.round,
                                center: Text(
                                  '${animation.value}%',
                                  style: GoogleFonts.nunito(
                                      fontSize: 10,
                                      color: const Color(0xCC3B3B3B)),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Duty Hours',
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: const Color(0xCC3B3B3B)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const BoxDecoration(
                              color: Color(0x1A6BB577),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(2),
                                  bottomLeft: Radius.circular(2),
                                  topRight: Radius.circular(2),
                                  bottomRight: Radius.circular(2))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/active_duty.png',
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                              const Spacer(),
                              Text(
                                'Active Duty (5)',
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: const Color(0xCC3B3B3B)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const BoxDecoration(
                              color: Color(0x1A6BB577),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(2),
                                  bottomLeft: Radius.circular(2),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/pending_duty.png',
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                              const Spacer(),
                              Text(
                                'Pending Duty (2)',
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: const Color(0xCC3B3B3B)),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xFFFCFCFC),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0x1A3B3B3B))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    'Email Address',
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B)),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: const Color(0x33D9D9D9),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      const Icon(Icons.mail),
                      const SizedBox(width: 8),
                      Text(
                        widget.requestForDutiesStudent.email,
                        style: GoogleFonts.nunito(
                            fontSize: 14, color: const Color(0xCC3B3B3B)),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    'Student Mobile No.',
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B)),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: const Color(0x33D9D9D9),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: 8),
                      Text(
                        widget.requestForDutiesStudent.contactNumber,
                        style: GoogleFonts.nunito(
                            fontSize: 14, color: const Color(0xCC3B3B3B)),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Course',
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)),
                            ),
                            Text(
                              widget.requestForDutiesStudent.course,
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                color: const Color(0xCC3B3B3B),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Semester',
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)),
                            ),
                            Text(
                              widget.requestForDutiesStudent.semester,
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                color: const Color(0xCC3B3B3B),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
