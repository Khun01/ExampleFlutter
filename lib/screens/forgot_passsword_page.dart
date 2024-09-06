import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/bloc/forgotPassword/forgot_password_bloc.dart';
import 'package:help_isko/components/my_button.dart';
import 'package:help_isko/components/my_form.dart';
import 'package:help_isko/screens/verification_page.dart';
import 'package:help_isko/services/auth_services.dart';
import 'package:help_isko/services/global.dart';

class ForgotPassswordPage extends StatelessWidget {
  const ForgotPassswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(authServices: AuthServices(apiUrl: baseUrl)),
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccessState) {
             ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.success)));
                Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationPage(email: state.email)));
          } else if (state is ForgotPasswordFailedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
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
                          'Forgot Password',
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
                            labelText: 'Email',
                            icon: const Icon(Icons.person),
                            onChanged: (value) => {
                                  context.read<ForgotPasswordBloc>().add(
                                      ForgotPasswordEmailChangedEvent(
                                          email: value))
                                }),
                        const SizedBox(height: 16),
                        MyButton(
                                onTap: () {
                                  context
                                      .read<ForgotPasswordBloc>()
                                      .add(ForgotPasswordClickedButtonEvent());
                                },
                                buttonText: 'Forgot Password')
                      ],
                    ),
                  ),
                  if (state is ForgotPasswordLoadingState) ...[
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
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
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
