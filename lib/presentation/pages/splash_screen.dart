import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/pages/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controllerImage;
  late AnimationController _controllerBg;
  late Animation<double> _scaleAnimationImage;
  late Animation<double> _scaleAnimationBg;

  @override
  void initState() {
    super.initState();
    _controllerImage = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controllerBg = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimationImage = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(parent: _controllerImage, curve: Curves.easeInOut),
    );

    _scaleAnimationBg = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(parent: _controllerBg, curve: Curves.easeInOut),
    );

    _controllerImage.forward();
    _controllerBg.forward();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 4), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const LandingPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0, -1);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              })
          // MaterialPageRoute(builder: (context) => const LandingPage())
          );
    });
  }

  @override
  void dispose() {
    _controllerImage.dispose();
    _controllerBg.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: _controllerBg,
          builder: (context, child) {
            return ScaleTransition(
              scale: _scaleAnimationBg,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: const Color(0xFFFCFCFC),
                    borderRadius: _scaleAnimationBg.value < 1
                        ? BorderRadius.circular(5000)
                        : BorderRadius.zero),
                child: ScaleTransition(
                  scale: _scaleAnimationImage,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Center(
                          child: Image.asset(
                            'assets/images/boaf_logo.png',
                            height: 350,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 80,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: Text(
                            'BOAF',
                            style: GoogleFonts.abhayaLibre(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2,
                              color: const Color(0xFF3B3B3B),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
