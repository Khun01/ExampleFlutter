import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/duty/add/add_duty_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/duty/show/posted_duties_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/announcement/announcement_bloc.dart';
import 'package:help_isko/presentation/pages/employee/firstPage/employee_duties_page.dart';
import 'package:help_isko/presentation/pages/employee/firstPage/employee_home_page.dart';
import 'package:help_isko/presentation/pages/employee/firstPage/employee_profile_page.dart';
import 'package:help_isko/presentation/pages/messenger_page.dart';
import 'package:help_isko/presentation/pages/students/firstPage/student_duties_page.dart';
import 'package:help_isko/presentation/pages/students/firstPage/student_profile_page.dart';
import 'package:help_isko/presentation/widgets/my_add_duty_bottom_dialog.dart';
import 'package:help_isko/presentation/pages/students/firstPage/student_home_page.dart';
import 'package:help_isko/repositories/api_repositories.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/services/duty_services.dart';
import 'package:ionicons/ionicons.dart';

class Wrapper extends StatefulWidget {
  final String role;

  const Wrapper({
    super.key,
    required this.role,
  });

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AnnouncementBloc announcementBloc =
        AnnouncementBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl))
          ..add(FetchAnnouncement(role: widget.role));
    final AddDutyBloc addDutyBloc =
        AddDutyBloc(dutyServices: DutyServices(baseUrl: baseUrl));
    final PostedDutiesBloc postedDutiesBloc =
        PostedDutiesBloc(dutyRepository: DutyServices(baseUrl: baseUrl))
          ..add(FetchDuty());
    return BlocProvider(
      create: (context) => postedDutiesBloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              IndexedStack(
                  index: selectedIndex,
                  children: widget.role == 'Employee'
                      ? [
                          MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: postedDutiesBloc,
                              ),
                              BlocProvider.value(
                                value: announcementBloc,
                              ),
                            ],
                            child: const EmployeeHomePage(),
                          ),
                          const EmployeeDutiesPage(),
                          const MessengerPage(
                            role: 'Employee',
                          ),
                          const EmployeeProfilePage()
                        ]
                      : const [
                          StudentHomePage(),
                          StudentDutiesPage(),
                          MessengerPage(
                            role: 'Student',
                          ),
                          StudentProfilePage()
                        ]),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, -6))
                  ]),
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 700),
                    child: BottomNavigationBar(
                      selectedItemColor: const Color(0xFF6BB577),
                      unselectedItemColor: const Color(0xFF3B3B3B),
                      selectedLabelStyle: GoogleFonts.nunito(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      items: [
                        BottomNavigationBarItem(
                            label: 'Home',
                            icon: selectedIndex == 0
                                ? const ImageIcon(
                                    AssetImage(
                                        'assets/images/home_clicked.png'),
                                    color: Color(0xFF6BB577))
                                : const ImageIcon(
                                    AssetImage('assets/images/home.png'))),
                        BottomNavigationBarItem(
                            label: widget.role == 'Employee'
                                ? 'Request'
                                : 'Duties',
                            icon: selectedIndex == 1
                                ? const ImageIcon(
                                    AssetImage(
                                        'assets/images/duties_clicked.png'),
                                    color: Color(0xFF6BB577))
                                : const ImageIcon(
                                    AssetImage('assets/images/duties.png'))),
                        BottomNavigationBarItem(
                            label: 'Message',
                            icon: selectedIndex == 2
                                ? const Icon(Ionicons.chatbubble_ellipses,
                                    color: Color(0xFF6BB577))
                                : const Icon(
                                    Ionicons.chatbubble_ellipses_outline)),
                        BottomNavigationBarItem(
                            label: 'Profile',
                            icon: selectedIndex == 3
                                ? const ImageIcon(AssetImage(
                                    'assets/images/circle-user-clicked.png'))
                                : const ImageIcon(AssetImage(
                                    'assets/images/circle-user.png')))
                      ],
                      currentIndex: selectedIndex,
                      onTap: (int index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
              if (widget.role == 'Employee' && selectedIndex == 0)
                Positioned(
                  bottom: 86,
                  right: 16,
                  child: FadeInRight(
                    duration: const Duration(milliseconds: 700),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xFF6BB577),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 6))
                          ]),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.85,
                                    child: MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                          value: addDutyBloc,
                                        ),
                                        BlocProvider.value(
                                          value: postedDutiesBloc,
                                        ),
                                      ],
                                      child: const MyAddDutyBottomDialog(),
                                    ));
                              });
                        },
                        child: const Icon(
                          Icons.add_rounded,
                          size: 40,
                          color: Color(0xFFFCFCFC),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
