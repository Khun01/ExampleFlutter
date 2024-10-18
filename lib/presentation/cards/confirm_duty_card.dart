import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/models/duty/completed_duty.dart';
import 'package:help_isko/presentation/bloc/employee/completedDuty/completed_duty_bloc.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:ionicons/ionicons.dart';

class ConfirmDutyCard extends StatelessWidget {
  final CompletedDuty completedDuty;
  ConfirmDutyCard({super.key, required this.completedDuty});

  final TextEditingController hoursFirstInput = TextEditingController();
  final TextEditingController hoursSecondInput = TextEditingController();
  final TextEditingController minuteFirstInput = TextEditingController();
  final TextEditingController minuteSecondInput = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const CircleAvatar(
                radius: 10,
                backgroundColor: Color(0xFF6BB577),
              ),
              const SizedBox(height: 8),
              Container(
                height: 120,
                width: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF6BB577)),
                ),
              )
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFCFCFC),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: const Color(0xFFD9D9D9)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0.0, 10.0),
                    blurRadius: 10.0,
                    spreadRadius: -6.0,
                  )
                ],
              ),
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
                        child: completedDuty.student!.profile != ''
                            ? ClipOval(
                                child: Image.network(
                                  '$profileUrl${completedDuty.student!.profile}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    margin: const EdgeInsets.all(14),
                                    child: Image.asset(
                                      'assets/images/profile_clicked.png',
                                    ),
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
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  completedDuty.student!.name ?? '',
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B),
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Ionicons.chatbubble_ellipses_outline,
                                  size: 20,
                                ),
                              ],
                            ),
                            Text(
                              completedDuty.student!.course ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                color: const Color(0xFF6B6B6B),
                              ),
                            ),
                            Text(
                              completedDuty.building ?? '',
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                color: const Color(0xFF6B6B6B),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  completedDuty.fulfilled == 1
                      ? Center(
                          child: Text(
                            'You already submitted this.',
                            style: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)
                            ),
                          ),
                        )
                      : Form(
                          key: _formkey,
                          child: Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                margin: const EdgeInsets.only(right: 4),
                                child: TextFormField(
                                  controller: hoursFirstInput,
                                  style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF3B3B3B)),
                                  onChanged: (value) {
                                    log('The token in the textField is; $value');
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                margin: const EdgeInsets.only(right: 4),
                                child: TextFormField(
                                  controller: hoursSecondInput,
                                  style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF3B3B3B)),
                                  onChanged: (value) {
                                    log('The token in the textField is; $value');
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              Text(
                                'Hrs',
                                style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 35,
                                height: 35,
                                margin: const EdgeInsets.only(right: 4),
                                child: TextFormField(
                                  controller: minuteFirstInput,
                                  style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B),
                                  ),
                                  onChanged: (value) {
                                    log('The token in the textField is; $value');
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                margin: const EdgeInsets.only(right: 4),
                                child: TextFormField(
                                  controller: minuteSecondInput,
                                  style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B),
                                  ),
                                  onChanged: (value) {
                                    log('The token in the textField is; $value');
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              Text(
                                'Mins',
                                style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (hoursFirstInput.text.isNotEmpty &&
                                        hoursSecondInput.text.isNotEmpty &&
                                        minuteFirstInput.text.isNotEmpty &&
                                        minuteSecondInput.text.isNotEmpty) {
                                      String hour = hoursFirstInput.text +
                                          hoursSecondInput.text;
                                      String minute = minuteFirstInput.text +
                                          minuteSecondInput.text;
                                      context.read<CompletedDutyBloc>().add(
                                          DutyAddHoursStudent(
                                              studentId: completedDuty
                                                  .student!.studentId,
                                              dutyId: completedDuty.dutyId!,
                                              hour: int.parse(hour),
                                              minute: int.parse(minute)));
                                    }
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF6BB577),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        'Submit',
                                        style: GoogleFonts.nunito(
                                          fontSize: 12,
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
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
