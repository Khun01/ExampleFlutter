part of 'announcement_bloc.dart';

sealed class AnnouncementEvent extends Equatable {
  const AnnouncementEvent();

  @override
  List<Object> get props => [];
}

class FetchAnnouncement extends AnnouncementEvent{
  final String role;

  const FetchAnnouncement({required this.role});
}
