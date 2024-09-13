part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
  
  @override
  List<Object> get props => [];

  bool get isEmpty => false;
}

final class ForgotPasswordInitial extends ForgotPasswordState {}


class ForgotPasswordLoadingState extends ForgotPasswordState{}

class ForgotPasswordSuccessState extends ForgotPasswordState{
  final String email;
  final String success;
  const ForgotPasswordSuccessState({required this.email, required this.success});
}

class ForgotPasswordFailedState extends ForgotPasswordState{
  final String error;

  const ForgotPasswordFailedState({required this.error});
}



class VerificationSuccessState extends ForgotPasswordState{
  final String token;
  
  const VerificationSuccessState({required this.token});
}

class VerificationLoadingState extends ForgotPasswordState{}

class VerificationFailedState extends ForgotPasswordState{
  final String error;

  const VerificationFailedState({required this.error});
}


class ChangePasswordLoadingState extends ForgotPasswordState{}

class ChangePasswordSuccessState extends ForgotPasswordState{}

class ChangePasswordFailedState extends ForgotPasswordState{
  final String error;

  const ChangePasswordFailedState({required this.error});
}