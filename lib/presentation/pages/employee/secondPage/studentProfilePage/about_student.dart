import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/models/duty/students.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AboutStudent extends StatefulWidget {
  final Students students;
  const AboutStudent({super.key, required this.students});

  @override
  State<AboutStudent> createState() => _AboutStudentState();
}

class _AboutStudentState extends State<AboutStudent>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  var percentage = 0.0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation = Tween<double>(begin: 0, end: 0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.reset();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    percentage = widget.students.percentage;
    animation = Tween<double>(begin: 0, end: percentage).animate(controller);
    controller.forward();
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
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: const Color(0xFFA3D9A5),
                          borderRadius: BorderRadius.circular(500)),
                      child: ClipOval(
                        child: widget.students.profile != ''
                            ? Image.network(
                                '$profileUrl${widget.students.profile}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  margin: const EdgeInsets.all(14),
                                  child: Image.asset(
                                    'assets/images/profile_clicked.png',
                                  ),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.all(14),
                                child: Image.asset(
                                  'assets/images/profile_clicked.png',
                                ),
                              ),
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
                                  widget.students.name!,
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF3B3B3B)),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    context.read<MessageBloc>().add(
                                          MessageNavigateToChatEvent(
                                              schoolId: widget
                                                  .students.studentNumber
                                                  .toString(),
                                              role: "Employee",
                                              targetUserId:
                                                  widget.students.studentId,
                                              name: widget.students.name!,
                                              profile:
                                                  widget.students.profile!),
                                        );
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
                              widget.students.studentNumber!,
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
                                percent: animation.value / 100,
                                circularStrokeCap: CircularStrokeCap.round,
                                center: Text(
                                  '${(animation.value).toStringAsFixed(2)}%',
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
                                'Active Duty ${widget.students.activeDutyCount}',
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
                                'Completed Duty ${widget.students.completedDutyCount}',
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
                        widget.students.email!,
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
                        widget.students.contactNumber!,
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
                              widget.students.course!,
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
                              widget.students.semester!,
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
                              'Duty hours',
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)),
                            ),
                            Text(
                              '${widget.students.hoursToComplete?? ''} Hours',
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
                              'Remaining hours',
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)),
                            ),
                            Text(
                              '${widget.students.remainingHours ?? ''} Hours',
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
