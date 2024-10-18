import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/models/duty/completed_duty.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:ionicons/ionicons.dart';

class ConfirmDutyCard extends StatelessWidget {
  final CompletedDuty completedDuty;
  const ConfirmDutyCard({super.key, required this.completedDuty});

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...List.generate(
                        2,
                        (index) => Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 4),
                          child: TextFormField(
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
                            ),
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
                      ...List.generate(
                        2,
                        (index) => Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 4),
                          child: TextFormField(
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
                            ),
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
                            log('The submit button is clcked');
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: const Color(0xFF6BB577),
                                borderRadius: BorderRadius.circular(10)),
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
