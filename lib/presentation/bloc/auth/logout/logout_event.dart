abstract class LogoutEvent{}

class LogoutButtonPressed extends LogoutEvent{
  final String role;

  LogoutButtonPressed({required this.role});
}