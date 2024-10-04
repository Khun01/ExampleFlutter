part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class FetchNotification extends NotificationEvent{
  final String role;

  const FetchNotification({required this.role});
}