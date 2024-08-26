abstract class LoginEvent{}

class LoginButtonPressed extends LoginEvent{
  final String email;
  final String password;
  final String selectedRole;

  LoginButtonPressed({
    required this.email, 
    required this.password,
    required this.selectedRole,
  });
}

class CheckLoginStatusEvent extends LoginEvent{
  final String selectedRole;
  CheckLoginStatusEvent({
    required this.selectedRole
  });
}