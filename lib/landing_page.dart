import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/bloc/login/login_bloc.dart';
import 'package:help_isko/bloc/login/login_event.dart';
import 'package:help_isko/bloc/login/login_state.dart';
import 'package:help_isko/components/my_button.dart';
import 'package:help_isko/components/my_form.dart';
import 'package:help_isko/services/auth_services.dart';
import 'package:help_isko/services/global.dart';
import 'package:help_isko/screens/students/firstPage/student_home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isTextSelected = false;
  String? selectedRole;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  bool handleBackPressed(){
    setState(() {
      email.clear();
      password.clear();
      isTextSelected = false;
      selectedRole = null;
    });
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authServices: AuthServices(apiUrl: baseUrl)
      ),
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state){
            if(state is LoginFailure){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error))
              );
            } else if(state is LoginSuccess){
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => const StudentHomePage())
              );
            }
          },
          builder: (context, state){
            return SafeArea(
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 900),
                    color: isTextSelected ? const Color(0xFFA3D9A5) : Theme.of(context).scaffoldBackgroundColor,
                    child: Stack(
                      children: [
                        if (isTextSelected)
                        Positioned(
                          top: 25,
                          left: 10,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              handleBackPressed();
                            },
                          ),
                        ),
                        AnimatedPositioned(
                          top: isTextSelected ? 80 : MediaQuery.of(context).size.height / 8,
                          left: 0,
                          right: 0,
                          duration: const Duration(milliseconds: 900),
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 900),
                                width: isTextSelected ? 150 : 200,
                                child: Image.asset(
                                  'assets/images/upang_logo.png',
                                ),
                              ),
                              const SizedBox(height: 20),
                              AnimatedOpacity(
                                opacity: isTextSelected ? 0 : 1,
                                duration: const Duration(seconds: 1),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'University\nof\nPangasinan',
                                  style: GoogleFonts.abhayaLibre(
                                    fontSize: 30,
                                    color: const Color(0xFF3B3B3B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 900),
                          top: isTextSelected ? 250 : MediaQuery.of(context).size.height / 1.7,
                          left: 0,
                          right: 0,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 900),
                            height: isTextSelected ? MediaQuery.of(context).size.height - 150 : MediaQuery.of(context).size.height / 1.5,
                            decoration: BoxDecoration(
                              color: isTextSelected ? const Color(0xFFFCFCFC) : const Color(0xFFA3D9A5),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                              boxShadow: isTextSelected ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  offset: const Offset(0.0, -10.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 6.0,
                                ),
                              ] : [],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50, left: 25, bottom: 70, right: 25),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 900),
                                transitionBuilder: (Widget child, Animation<double> animation) {
                                  return FadeTransition(opacity: animation, child: child);
                                },
                                child: isTextSelected ? Column(
                                  key: const ValueKey(1),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selectedRole == 'Professor' ? 'Professor' : 'Student',
                                      style: GoogleFonts.nunito(
                                        fontSize: 40,
                                        color: const Color(0xFF3B3B3B),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    MyForm(
                                      controller: email,
                                      hintText: 'ID Number',
                                      obscureText: false,
                                      icon: Icons.person,
                                    ),
                                    const SizedBox(height: 20),
                                    MyForm(
                                      controller: password,
                                      hintText: 'Password',
                                      obscureText: true,
                                      icon: Icons.lock,
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                      'Forgot Password?',
                                        style: GoogleFonts.nunito(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF3B3B3B),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    state is LoginLoading ? const Center(child: CircularProgressIndicator()) :
                                    Align(
                                      child: MyButton(
                                        onTap: () {
                                          context.read<LoginBloc>().add(
                                            LoginButtonPressed(
                                              email: email.text,
                                              password: password.text,
                                              selectedRole: selectedRole!
                                            ),
                                          );
                                        },
                                        buttonText: 'Login',
                                      ),
                                    ),
                                  ],
                                ) : Column(
                                  key: const ValueKey(2),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome',
                                      style: GoogleFonts.nunito(
                                        fontSize: 40,
                                        color: const Color(0xFF3B3B3B),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      'Track duties, grab opportunities, and stay organized. Simplify your journey with the Scholarship App. Join the Scholarship App today!',
                                      style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        color: const Color(0xFF3B3B3B),
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: MyButton(
                                            onTap: () {
                                              setState(() {
                                                isTextSelected = true;
                                                selectedRole = 'Professor';
                                              });
                                              // context.read<LoginBloc>().add(LoginSelectedProfessorRoleEvent());
                                            },
                                            buttonText: 'Professor',
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: MyButton(
                                            onTap: () {
                                              setState(() {
                                                isTextSelected = true;
                                                selectedRole = 'Student';
                                              });
                                            },
                                            buttonText: 'Student',
                                            color: const Color(0xFFF4F4F4),
                                            textColor: const Color(0xFF3B3B3B),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
