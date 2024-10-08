import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/auth/login/login_bloc.dart';
import 'package:help_isko/presentation/bloc/auth/login/login_event.dart';
import 'package:help_isko/presentation/bloc/auth/login/login_state.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';
import 'package:help_isko/presentation/pages/auth/login_page.dart';
import 'package:help_isko/presentation/pages/wrapper.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_circular_progress_indicator.dart';
import 'package:help_isko/repositories/api_repositories.dart';
import 'package:help_isko/repositories/global.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedRole;

    return BlocProvider(
      create: (context) =>
          LoginBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.isSuccess) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Wrapper(role: selectedRole!)));
              } else if (state.hasFailed && !state.isSubmitting) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage(role: selectedRole!)));
              }
            },
            builder: (context, state) {
              return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Color(0x33A3D9A5)),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: FadeIn(
                          duration: const Duration(seconds: 3),
                          child: Image.asset(
                            'assets/images/background.png',
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 50, bottom: 16, left: 16, right: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: FadeIn(
                                  duration: const Duration(seconds: 3),
                                  child: Image.asset(
                                    'assets/images/upang_logo.png',
                                    fit: BoxFit.contain,
                                    width: 250,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FadeIn(
                                      duration: const Duration(seconds: 3),
                                      child: FittedBox(
                                        child: Text(
                                          'Welcome to Help, isKo',
                                          style: GoogleFonts.nunito(
                                              fontSize: 80,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF3B3B3B)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: FadeIn(
                                        duration: const Duration(seconds: 3),
                                        child: Text(
                                          'Track duties, grab opportunities, and stay organized. Simplify your journey with the Help, isKo App. Join the Help, isKo App today!',
                                          style: GoogleFonts.nunito(
                                              fontSize: 15,
                                              color: const Color(0xCC3B3B3B)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    FadeIn(
                                      duration: const Duration(seconds: 3),
                                      child: MyButton(
                                        onTap: () {
                                          selectedRole = 'Employee';
                                          context.read<LoginBloc>().add(
                                              CheckLoginStatusEvent(
                                                  role: selectedRole!));
                                        },
                                        buttonText: 'Employee',
                                        color: const Color(0xFF6BB577),
                                        textColor: const Color(0xFFFCFCFC),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    FadeIn(
                                      duration: const Duration(seconds: 3),
                                      child: MyButton(
                                        onTap: () {
                                          selectedRole = 'Student';
                                          context.read<LoginBloc>().add(
                                              CheckLoginStatusEvent(
                                                  role: selectedRole!));
                                        },
                                        buttonText: 'Student',
                                        color: const Color(0xFFFCFCFC),
                                        textColor: const Color(0xFF3B3B3B),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      if (state.isSubmitting) ...[
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const Center(
                          child: MyCircularProgressIndicator(),
                        ),
                      ]
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
