import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/components/my_button.dart';
import 'package:help_isko/components/my_form.dart';
import 'package:help_isko/screens/landing_page.dart';

class ChangePasswordPage extends StatelessWidget {
  final String token; 

  const ChangePasswordPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/login_bg.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFFFCFCFC),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/upang_logo.png',
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Text(
                    'Reset Password',
                    style: GoogleFonts.nunito(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      'Enter your email to reset it and regain access to your account',
                      style: GoogleFonts.nunito(
                          fontSize: 14, color: const Color(0xFF3B3B3B)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  MyForm(
                    labelText: 'Password', 
                    icon: const Icon(Icons.lock), 
                    onChanged: (value) => {}
                  ),
                  const SizedBox(height: 16),
                  MyForm(
                    labelText: 'Confirm Password', 
                    icon: const Icon(Icons.lock), 
                    onChanged: (value) => {}
                  ),
                  const SizedBox(height: 16),
                  MyButton(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LandingPage()));
                    }, 
                    buttonText: 'Reset Password'
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}