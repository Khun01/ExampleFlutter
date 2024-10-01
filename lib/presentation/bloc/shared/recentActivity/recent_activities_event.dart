part of 'recent_activities_bloc.dart';

sealed class RecentActivitiesEvent extends Equatable {
  const RecentActivitiesEvent();

  @override
  List<Object> get props => [];
}

class FetchRecentActivitiesEvent extends RecentActivitiesEvent{
  final String role;

  const FetchRecentActivitiesEvent({required this.role}); 
}