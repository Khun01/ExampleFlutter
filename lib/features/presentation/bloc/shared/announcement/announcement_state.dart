part of 'announcement_bloc.dart';

sealed class AnnouncementState extends Equatable {
  const AnnouncementState();
  
  @override
  List<Object> get props => [];
}

final class AnnouncementInitial extends AnnouncementState {}

class AnnouncementFailedState extends AnnouncementState{
  final String error;

  const AnnouncementFailedState ({required this.error});
}

class AnnouncementLoadingState extends AnnouncementState{}

class AnnouncementSuccessState extends AnnouncementState{
  final List<Announcement> announcement;

  const AnnouncementSuccessState ({required this.announcement});
}
