import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/auth/login/login_bloc.dart';
import 'package:help_isko/presentation/bloc/auth/login/login_event.dart';
import 'package:help_isko/presentation/bloc/auth/login/login_state.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_circular_progress_indicator.dart';
import 'package:help_isko/presentation/widgets/my_form.dart';
import 'package:help_isko/presentation/pages/auth/forgot_passsword_page.dart';
import 'package:help_isko/presentation/pages/wrapper.dart';
import 'package:help_isko/repositories/api_repositories.dart';
import 'package:help_isko/repositories/global.dart';

class LoginPage extends StatelessWidget {
  final String? role;

  const LoginPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.isSuccess && !state.isSubmitting) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Wrapper(role: role!)));
              } else if (state.hasFailed && !state.isSubmitting) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureMessage!)));
              } else if (state.isSubmitting) {
                FocusScope.of(context).unfocus();
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Stack(
                          children: [
                            Image.asset('assets/images/login_bg.png',
                                height: 350,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover),
                            Positioned(
                              top: 50,
                              left: 50,
                              right: 50,
                              bottom: 70,
                              child: Image.asset(
                                'assets/images/upang_logo.png',
                              ),
                            ),
                            Positioned(
                                top: 16,
                                left: 16,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: 24,
                                    color: Color(0xFFFCFCFC),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                role!,
                                style: GoogleFonts.nunito(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  'Please sign in to your account',
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      color: const Color(0xFF3B3B3B)),
                                ),
                              ),
                              const SizedBox(height: 24),
                              MyForm(
                                  labelText: 'Email',
                                  errorText: !state.isEmailNotEmpty
                                      ? 'Enter email'
                                      : (!state.isEmailValid
                                          ? 'Invalid email'
                                          : null),
                                  icon: const Icon(Icons.person),
                                  onChanged: (value) => context
                                      .read<LoginBloc>()
                                      .add(LoginEmailChanged(email: value))),
                              const SizedBox(height: 16),
                              MyForm(
                                  labelText: 'Password',
                                  errorText: !state.isPasswordNotEmpty
                                      ? 'Enter password'
                                      : (!state.isPasswordValid
                                          ? 'Password should be greater than 6'
                                          : null),
                                  icon: const Icon(Icons.lock),
                                  obscureText: true,
                                  onChanged: (value) => context
                                      .read<LoginBloc>()
                                      .add(LoginPassChanged(password: value))),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPassswordPage()));
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        color: const Color(0xFF3B3B3B)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              MyButton(
                                  onTap: state.isFormValid
                                      ? () => context
                                          .read<LoginBloc>()
                                          .add(LoginSubmitted(role: role!))
                                      : null,
                                  buttonText: 'Login')
                            ],
                          ),
                        ),
                      )
                    ],
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
              );
            },
          ),
        ),
      ),
    );
  }
}
