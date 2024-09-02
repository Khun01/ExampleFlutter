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
