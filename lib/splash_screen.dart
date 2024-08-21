import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/bloc/login/login_bloc.dart';
import 'package:help_isko/bloc/login/login_event.dart';
import 'package:help_isko/bloc/login/login_state.dart';
import 'package:help_isko/services/auth_services.dart';
import 'package:help_isko/services/global.dart';
import 'package:help_isko/landing_page.dart';
import 'package:help_isko/screens/students/firstPage/student_home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(authServices: AuthServices(apiUrl: baseUrl)),
      child: Builder(
        builder: (context) {
          context.read<LoginBloc>().add(CheckLoginStatusEvent());
          return Scaffold(
            body: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const StudentHomePage()
                    ),
                  );
                } else if (state is LoginFailure) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LandingPage()
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Container(
                  color: const Color(0xFFE2B34B),
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 800,
                      height: 800,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
