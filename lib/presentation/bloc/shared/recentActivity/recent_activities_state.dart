part of 'recent_activities_bloc.dart';

sealed class RecentActivitiesState extends Equatable {
  const RecentActivitiesState();
  
  @override
  List<Object> get props => [];
}

final class RecentActivitiesInitial extends RecentActivitiesState {}

class RecentActivitiesSuccessState extends RecentActivitiesState{
  final List<RecentActivities> recentActivities;

  const RecentActivitiesSuccessState({required this.recentActivities});
}

class RecentActivitiesFailedState extends RecentActivitiesState{
  final String error;

  const RecentActivitiesFailedState({required this.error});
}

class RecentActivitiesLoadingState extends RecentActivitiesState{}
