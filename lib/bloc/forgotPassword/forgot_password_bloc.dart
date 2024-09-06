import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/services/auth_services.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthServices authServices;
  ForgotPasswordBloc({required this.authServices})
      : super(ForgotPasswordInitial()) {
    on<ForgotPasswordClickedButtonEvent>(forgotPasswordClickedButtonEvent);
    on<ForgotPasswordEmailChangedEvent>(forgotPasswordEmailChangedEvent);
    on<VerificationClickedButtonEvent>(verificationClickedButtonEvent);
    on<VerificationTokenChangedEvent>(verificationTokenChangedEvent);
    on<ChangePasswordClickedButtonEvent>(changePasswordClickedButtonEvent);
    on<ChangePasswordChangedEvent>(changePasswordChangedEvent);
    on<ChangeConfirmPasswordChangedEvent>(changeConfirmPasswordChangedEvent);
  }

  String email = '';
  List<String> tokens = List.filled(4, '');
  String password = '';
  String confrimPassword = '';

  FutureOr<void> forgotPasswordClickedButtonEvent(
      ForgotPasswordClickedButtonEvent event,
      Emitter<ForgotPasswordState> emit) async {
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(emailPattern);

    try {
      emit(ForgotPasswordLoadingState());
      if (email.isNotEmpty) {
        if (regex.hasMatch(email)) {
          await Future.delayed(const Duration(seconds: 2));
          final response = await authServices.forgotPassword(email);
          // final statusCode = response['statusCode'];
          if (response['statusCode'] == 200) {
            emit(ForgotPasswordSuccessState(
                email: email, success: 'A code was sent to your email'));
          } else {
            String errorMessage = '';
            switch (response['statusCode']) {
              case 404:
                errorMessage = 'No record found';
                break;
            }
            emit(ForgotPasswordFailedState(error: errorMessage));
          }
        } else {
          emit(const ForgotPasswordFailedState(
            error: 'Email is not valid',
          ));
        }
      } else {
        emit(const ForgotPasswordFailedState(error: 'Email cannot be empty'));
      }
    } catch (e) {
      log('The error message is: ${e.toString()}');
      emit(ForgotPasswordFailedState(error: e.toString()));
    }
  }

  FutureOr<void> forgotPasswordEmailChangedEvent(
      ForgotPasswordEmailChangedEvent event,
      Emitter<ForgotPasswordState> emit) {
    email = event.email;
  }

  FutureOr<void> verificationClickedButtonEvent(
      VerificationClickedButtonEvent event,
      Emitter<ForgotPasswordState> emit) async {
    log('The verification button is clicked');
    final token = tokens.join('');
    try {
      emit(VerificationLoadingState());
      if (token.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 2));
        log('The token is: $token');
        emit(VerificationSuccessState(token: token));
        // final response = await
      } else {
        emit(const VerificationFailedState(error: 'Token cannot be empty'));
      }
    } catch (e) {
      emit(VerificationFailedState(error: e.toString()));
    }
  }

  FutureOr<void> verificationTokenChangedEvent(
      VerificationTokenChangedEvent event, Emitter<ForgotPasswordState> emit) {
    final index = event.index;
    if (index >= 0 && index < tokens.length) {
      tokens[index] = event.token;
      log('Token at index $index updated to ${event.token}');
    }
  }

  FutureOr<void> changePasswordClickedButtonEvent(
      ChangePasswordClickedButtonEvent event,
      Emitter<ForgotPasswordState> emit) async {
    try {
      emit(ChangePasswordLoadingState());
      if (password.isNotEmpty || confrimPassword.isNotEmpty) {
        if (password.length >= 6 || confrimPassword.length >= 6) {
          if (password == confrimPassword) {
            await Future.delayed(const Duration(seconds: 2));

            final response = await authServices.resetPassword(
                event.email, password, confrimPassword, event.token);
            if (response['statusCode'] == 200) {
              log('The code is: ${response['statusCode']}');
              emit(ChangePasswordSuccessState());
            } else if (response['message'] == 'token mismatch' || response['statusCode'] == 400) {
              emit(const ChangePasswordFailedState(
                  error: 'Invalid token. Redirecting back . . .'));
            }else if(response['statusCode'] == 404){
              emit(const ChangePasswordFailedState(
                  error: 'No record found, Incorrect email address'));
            } else {
              emit(ChangePasswordFailedState(
                  error: response['message'] ?? 'Failed to reset password'));
            }
          } else {
            emit(const ChangePasswordFailedState(
                error: 'Passwords do not match'));
          }
        } else {
          emit(const ChangePasswordFailedState(
              error: 'Password and confirm password should be greater than 6'));
        }
      } else {
        emit(const ChangePasswordFailedState(
            error: 'Password and confirm password caonnt be empty'));
      }
    } catch (e) {
      log('Error: ${e.toString()}');
      emit(ChangePasswordFailedState(error: e.toString()));
    }
  }

  FutureOr<void> changePasswordChangedEvent(
      ChangePasswordChangedEvent event, Emitter<ForgotPasswordState> emit) {
    password = event.password;
  }

  FutureOr<void> changeConfirmPasswordChangedEvent(
      ChangeConfirmPasswordChangedEvent event,
      Emitter<ForgotPasswordState> emit) {
    confrimPassword = event.confirmPassword;
  }
}
