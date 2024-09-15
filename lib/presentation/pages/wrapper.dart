import 'package:flutter/material.dart';
import 'package:help_isko/presentation/pages/employee/firstPage/employee_duties_page.dart';
import 'package:help_isko/presentation/pages/employee/firstPage/employee_home_page.dart';
import 'package:help_isko/presentation/pages/employee/firstPage/employee_profile_page.dart';
import 'package:help_isko/presentation/pages/messenger_page.dart';
import 'package:help_isko/presentation/pages/students/firstPage/student_duties_page.dart';
import 'package:help_isko/presentation/pages/students/firstPage/student_profile_page.dart';
import 'package:help_isko/presentation/widgets/my_add_duty_bottom_dialog.dart';
import 'package:help_isko/presentation/pages/students/firstPage/student_home_page.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
                index: selectedIndex,
                children: widget.role == 'Employee'
                    ? const [
                        EmployeeHomePage(),
                        EmployeeDutiesPage(),
                        MessengerPage(),
                        EmployeeProfilePage()
                      ]
                    : const [
                        StudentHomePage(),
                        StudentDutiesPage(),
                        MessengerPage(),
                        StudentProfilePage()
                      ]),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            spreadRadius: 1,
                            blurRadius: 6,
                          offset: const Offset(0, -6))
                    ]),
                child: BottomNavigationBar(
                  selectedItemColor: const Color(0xFF8CC9A6),
                  unselectedItemColor: const Color(0xFF3B3B3B),
                  selectedLabelStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  items: [
                    BottomNavigationBarItem(
                        label: 'Home',
                        icon: selectedIndex == 0
                            ? const ImageIcon(
                                AssetImage('assets/images/home_clicked.png'),
                                color: Color(0xFF6BB577))
                            : const ImageIcon(
                                AssetImage('assets/images/home.png'))),
                    BottomNavigationBarItem(
                        label:
                            widget.role == 'Employee' ? 'Request' : 'Duties',
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
                            ? const ImageIcon(
                                AssetImage(
                                    'assets/images/profile_clicked.png'),
                                color: Color(0xFF6BB577))
                            : const ImageIcon(
                                AssetImage('assets/images/profile.png')))
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
            if (widget.role == 'Employee')
              Positioned(
                bottom: 125,
                right: 15,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: const Color(0x303B3B3B)),
                      color: Theme.of(context).scaffoldBackgroundColor,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.85,
                                child: const MyAddDutyBottomDialog());
                          });
                    },
                    child: const Icon(
                      Icons.add_rounded,
                      size: 40,
                      color: Color(0xFF6BB577),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
