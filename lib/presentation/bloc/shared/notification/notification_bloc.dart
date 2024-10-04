import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/data/notification.dart';
import 'package:help_isko/repositories/api_repositories.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final ApiRepositories apiRepositories;
  NotificationBloc({required this.apiRepositories})
      : super(NotificationInitial()) {
    on<FetchNotification>(fetchNotification);
  }

  FutureOr<void> fetchNotification(
      FetchNotification event, Emitter<NotificationState> emit) async {
    emit(NotificationLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final notification = await apiRepositories.fetchNotification(event.role);
      emit(NotificationSuccessState(
        today: notification['today'] ?? [],
        yesterday: notification['yesterday'] ?? [],
        byDate: notification['by_date'] ?? [],
      ));
    } catch (e) {
      emit(NotificationFailedState(error: e.toString()));
    }
  }
}
