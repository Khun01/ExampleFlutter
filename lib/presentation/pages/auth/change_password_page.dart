import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/auth/forgotPassword/forgot_password_bloc.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';
import 'package:help_isko/presentation/widgets/my_form.dart';
import 'package:help_isko/presentation/pages/landing_page.dart';
import 'package:help_isko/repositories/api_repositories.dart';
import 'package:help_isko/repositories/global.dart';

class ChangePasswordPage extends StatelessWidget {
  final String token;
  final String email;

  const ChangePasswordPage(
      {super.key, required this.token, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ForgotPasswordBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl)),
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LandingPage()));
          } else if (state is ChangePasswordFailedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
            if (state.error == 'Invalid token. Redirecting back . . .') {
              Future.delayed(const Duration(seconds: 2), () {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              });
            }
          } else if (state is ChangePasswordLoadingState) {
            FocusScope.of(context).unfocus();
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
                          'Reset Password',
                          style: GoogleFonts.nunito(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Enter your new password to access your account.',
                            style: GoogleFonts.nunito(
                                fontSize: 14, color: const Color(0xFF3B3B3B)),
                          ),
                        ),
                        const SizedBox(height: 24),
                        MyForm(
                            labelText: 'Password',
                            icon: const Icon(Icons.lock),
                            obscureText: true,
                            onChanged: (value) => context
                                .read<ForgotPasswordBloc>()
                                .add(ChangePasswordChangedEvent(
                                    password: value))),
                        const SizedBox(height: 16),
                        MyForm(
                            labelText: 'Confirm Password',
                            icon: const Icon(Icons.lock),
                            obscureText: true,
                            onChanged: (value) => context
                                .read<ForgotPasswordBloc>()
                                .add(ChangeConfirmPasswordChangedEvent(
                                    confirmPassword: value))),
                        const SizedBox(height: 16),
                        MyButton(
                            onTap: () {
                              context.read<ForgotPasswordBloc>().add(
                                  ChangePasswordClickedButtonEvent(
                                      email: email, token: token));
                            },
                            buttonText: 'Reset Password')
                      ],
                    ),
                  ),
                  if (state is ChangePasswordLoadingState) ...[
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
