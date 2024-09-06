part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordClickedButtonEvent extends ForgotPasswordEvent{}

class ForgotPasswordEmailChangedEvent extends ForgotPasswordEvent{
  final String email;

  const ForgotPasswordEmailChangedEvent({required this.email});
}

class VerificationClickedButtonEvent extends ForgotPasswordEvent{}

class VerificationTokenChangedEvent extends ForgotPasswordEvent{
  final String token;
  final int index;

  const VerificationTokenChangedEvent({required this.token, required this.index});
} 


class ChangePasswordClickedButtonEvent extends ForgotPasswordEvent{
  final String email;
  final String token;
  const ChangePasswordClickedButtonEvent({required this.token, required this.email});
}

class ChangePasswordChangedEvent extends ForgotPasswordEvent{
  final String password;

  const ChangePasswordChangedEvent({required this.password});
} 


class ChangeConfirmPasswordChangedEvent extends ForgotPasswordEvent{
  final String confirmPassword;

  const ChangeConfirmPasswordChangedEvent({required this.confirmPassword});
} 
