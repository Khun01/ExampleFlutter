part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationSuccessState extends NotificationState {
  final List<Notification> today;
  final List<Notification> yesterday;
  final Map<String, List<Notification>> byDate;

  const NotificationSuccessState({
    required this.today,
    required this.yesterday,
    required this.byDate,
  });
}

class NotificationFailedState extends NotificationState {
  final String error;

  const NotificationFailedState({required this.error});
}
