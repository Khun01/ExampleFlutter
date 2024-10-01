import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/data/recent_activities.dart';
import 'package:help_isko/repositories/api_repositories.dart';

part 'recent_activities_event.dart';
part 'recent_activities_state.dart';

class RecentActivitiesBloc extends Bloc<RecentActivitiesEvent, RecentActivitiesState> {
  final ApiRepositories apiRepositories;
  RecentActivitiesBloc({required this.apiRepositories}) : super(RecentActivitiesInitial()) {
    on<FetchRecentActivitiesEvent>(fetchRecentActivitiesEvent);
  }

  FutureOr<void> fetchRecentActivitiesEvent(FetchRecentActivitiesEvent event, Emitter<RecentActivitiesState> emit) async{
    emit(RecentActivitiesLoadingState());
    try{
      final recentActivities = await apiRepositories.fetchRecentActivities();
      emit(RecentActivitiesSuccessState(recentActivities: recentActivities));
    }catch(e){
      emit(RecentActivitiesFailedState(error: e.toString()));
    }
  }
}
