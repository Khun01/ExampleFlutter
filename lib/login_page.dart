import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final String selectedRole;
  // final VoidCallback onClose;

  const LoginPage({
    super.key,
    required this.selectedRole,
    // required this.onClose
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFFFCFCFC),
                )
              ),
              Text(
                widget.selectedRole,
                style: GoogleFonts.nunito(
                  fontSize: 50
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}