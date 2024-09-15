import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/data/announcement.dart';
import 'package:help_isko/repositories/api_repositories.dart';

part 'announcement_event.dart';
part 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final ApiRepositories apiRepositories;
  AnnouncementBloc({required this.apiRepositories}) : super(AnnouncementInitial()) {
    on<FetchAnnouncement>(fetchAnnouncement);
  }

  FutureOr<void> fetchAnnouncement(FetchAnnouncement event, Emitter<AnnouncementState> emit) async{
    emit(AnnouncementLoadingState());
    try{
      await Future.delayed(const Duration(seconds: 2));
      final announcement = await apiRepositories.fetchAnnouncement(event.role);
      emit(AnnouncementSuccessState(announcement: announcement));
    }catch(e){
      emit(AnnouncementFailedState(error: e.toString()));
    }
  }
}
