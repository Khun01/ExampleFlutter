import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/auth/forgotPassword/forgot_password_bloc.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';
import 'package:help_isko/presentation/widgets/my_verification_text_field.dart';
import 'package:help_isko/presentation/pages/auth/change_password_page.dart';
import 'package:help_isko/services/auth_services.dart';
import 'package:help_isko/services/global.dart';

class VerificationPage extends StatelessWidget {
  final String email;
  const VerificationPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ForgotPasswordBloc(authServices: AuthServices(apiUrl: baseUrl)),
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is VerificationSuccessState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChangePasswordPage(token: state.token, email: email)));
          } else if (state is VerificationFailedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is VerificationLoadingState){
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
                          'Verification',
                          style: GoogleFonts.nunito(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Enter the verification code sent to your email to reset your password',
                            style: GoogleFonts.nunito(
                                fontSize: 14, color: const Color(0xFF3B3B3B)),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Form(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              4,
                              (index) => MyVerificationTextField(
                                onChanged: (value) {
                                  context.read<ForgotPasswordBloc>().add(
                                        VerificationTokenChangedEvent(
                                          index: index,
                                          token: value,
                                        ),
                                      );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        MyButton(
                            onTap: () {
                              context
                                  .read<ForgotPasswordBloc>()
                                  .add(VerificationClickedButtonEvent());
                            },
                            buttonText: 'Submit')
                      ],
                    ),
                  ),
                  if (state is VerificationLoadingState) ...[
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
