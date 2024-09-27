import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/models/data/prof_duty.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/duty_info_page.dart/duty_details.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/duty_info_page.dart/duty_details_student.dart';
import 'package:ionicons/ionicons.dart';

class PostedDutyInfoPage extends StatelessWidget {
  final ProfDuty profDuty;
  const PostedDutyInfoPage({super.key, required this.profDuty});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: const Color(0x1AA3D9A5),
                            borderRadius: BorderRadius.circular(20)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Ionicons.chevron_back_outline),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'Duty Details',
                          style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              TabBar(
                tabs: const [Tab(text: 'Duty'), Tab(text: 'Students')],
                labelStyle: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B)),
                indicatorColor: const Color(0xFF6BB577),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    DutyDetails(profDuty: profDuty),
                    const DutyDetailsStudent()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
