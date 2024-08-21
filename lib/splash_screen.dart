import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/bloc/login/login_bloc.dart';
import 'package:help_isko/bloc/login/login_event.dart';
import 'package:help_isko/bloc/login/login_state.dart';
import 'package:help_isko/services/auth_services.dart';
import 'package:help_isko/services/global.dart';
import 'package:help_isko/landing_page.dart';
import 'package:help_isko/screens/students/firstPage/student_home_page.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _positionAnimation;
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _positionAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isAnimated = true;
      });
    });

  }
 
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
                }
              },
              builder: (context, state) {
                bool showSlideAction = state is LoginFailure;
                return Container(
                  color: _isAnimated && showSlideAction ? const Color(0xFFF6F6F6) : const Color(0xFFA3D9A5),
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut,
                        top: _isAnimated && showSlideAction ? 100 : MediaQuery.of(context).size.height / 2 - 100,
                        left: 0,
                        right: 0,
                        child: SlideTransition(
                          position: showSlideAction ? const AlwaysStoppedAnimation<Offset>(Offset.zero) : _positionAnimation,
                          child: ScaleTransition(
                            scale: showSlideAction ? const AlwaysStoppedAnimation<double>(1.0) : _scaleAnimation,
                            child: Column(
                              children: [
                                Text(
                                  'PHINMA EDUCATION',
                                  style: GoogleFonts.abhayaLibre(
                                    fontSize: 30,
                                    color: const Color(0xFF3B3B3B),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/phinma_logo.png',
                                  height: 200,
                                  width: 200,
                                ),
                                const SizedBox(height: 30),
                                AnimatedOpacity(
                                  duration: showSlideAction ? Duration.zero : const Duration(seconds: 1),
                                  opacity: _isAnimated ? 1.0 : 0.0,
                                  child: Transform.translate(
                                    offset: Offset(0, _isAnimated ? 0 : 50),
                                    child: Text(
                                      'HK Scholarships',
                                      style: GoogleFonts.abhayaLibre(
                                        fontSize: 30,
                                        color: const Color(0xFF3B3B3B),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut,
                        bottom: _isAnimated ? 25 : -100,
                        left: 0,
                        right: 0,
                        child: AnimatedOpacity(
                          opacity: showSlideAction ? 1 : 0,
                          duration: const Duration(seconds: 1),
                          child: SlideAction(
                            outerColor: const Color(0xFFA3D9A5),
                            innerColor: const Color(0xFFF6F6F6),
                            elevation: 10,
                            text: 'Get Started',
                            textStyle: GoogleFonts.nunito(
                              color: const Color(0xFF3B3B3B),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            onSubmit: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 900),
                                  pageBuilder: (context, animation, secondaryAnimation) => const LandingPage(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(0, 1);
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;
                          
                                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                    var offsetAnimation = animation.drive(tween);
                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
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
