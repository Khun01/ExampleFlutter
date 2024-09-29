import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/models/duty/request_for_duties_student.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/studentProfilePage/about_student.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/studentProfilePage/reviews_student.dart';
import 'package:ionicons/ionicons.dart';

class StudentInfoPage extends StatelessWidget {
  final RequestForDutiesStudent requestForDutiesStudent;
  const StudentInfoPage({super.key, required this.requestForDutiesStudent});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
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
                              "Student's Profile",
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
                    tabs: const [Tab(text: 'About'), Tab(text: 'Reviews')],
                    labelStyle: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B3B3B),
                    ),
                    indicatorColor: const Color(0xFF3B3B3B),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        AboutStudent(requestForDutiesStudent: requestForDutiesStudent),
                        const ReviewsStudent()
                      ],
                    ),  
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
