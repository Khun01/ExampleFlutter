import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/bloc/login/login_bloc.dart';
import 'package:help_isko/bloc/login/login_event.dart';
import 'package:help_isko/bloc/login/login_state.dart';
import 'package:help_isko/components/my_button.dart';
import 'package:help_isko/login_page.dart';
import 'package:help_isko/screens/professors/firstPage/professor_home_page.dart';
import 'package:help_isko/services/auth_services.dart';
import 'package:help_isko/services/global.dart';
import 'package:help_isko/screens/students/firstPage/student_home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(authServices: AuthServices(apiUrl: baseUrl)),
      child: Builder(builder: (context) {
        return Scaffold(
          body: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
            log('The state is : $selectedRole');
              if (state is LoginSuccess) {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => selectedRole == 'Student' ? const StudentHomePage() : const ProfessorHomePage(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child){
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    } 
                  ),
                );
              }else if(state is LoginFailure){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error))
                );
                Navigator.push(
                  context,
                  // MaterialPageRoute(
                  //   builder: (context) => selectedRole == 'Student' ? LoginPage(selectedRole: selectedRole!) : LoginPage(selectedRole: selectedRole!) 
                  // )
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return selectedRole == 'Student'
                          ? LoginPage(selectedRole: selectedRole!)
                          : LoginPage(selectedRole: selectedRole!);
                    },
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      // Fade transition
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              }
            },
            builder: (context, state) {
              return SafeArea(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  color: const Color(0x33A3D9A5),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Image.asset(
                          'assets/images/background.png',
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 50, bottom: 15),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/upang_logo.png',
                              width: 200,
                              height: 200,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'University\nof\nPangasinan',
                              style: GoogleFonts.abhayaLibre(
                                  fontSize: 30, color: const Color(0xFF3B3B3B)),
                            ),
                            const Spacer(),
                            Padding(
                              padding:const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                'Welcome to Help, isKo',
                                style: GoogleFonts.nunito(
                                  fontSize: 36.4,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              child: Text(
                                'Track duties, grab opportunities, and stay organized. Simplify your journey with the Help, isKo App. Join the Help, isKo App today!',
                                style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  color: const Color(0xCC3B3B3B)
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            MyButton(
                              onTap: () {
                                setState(() {
                                  selectedRole = 'Professor';
                                });
                                context.read<LoginBloc>().add(CheckLoginStatusEvent(selectedRole: selectedRole!));
                              },
                              buttonText: 'Professor',
                              color: const Color(0xFF6BB577),
                              textColor: const Color(0xFFFCFCFC),
                            ),
                            const SizedBox(height: 15),
                            MyButton(
                              onTap: () {
                                setState(() {  
                                  selectedRole = 'Student';
                                });
                                context.read<LoginBloc>().add(CheckLoginStatusEvent(selectedRole: selectedRole!));
                              },
                              buttonText: 'Student',
                              color: const Color(0xFFFCFCFC),
                              textColor: const Color(0xFF3B3B3B),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
