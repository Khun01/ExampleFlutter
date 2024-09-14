import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/data/announcement.dart';
import 'package:help_isko/services/auth_services.dart';

part 'announcement_event.dart';
part 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final AuthServices authServices;
  AnnouncementBloc({required this.authServices}) : super(AnnouncementInitial()) {
    on<FetchAnnouncement>(fetchAnnouncement);
  }

  FutureOr<void> fetchAnnouncement(FetchAnnouncement event, Emitter<AnnouncementState> emit) async{
    emit(AnnouncementLoadingState());
    try{
      await Future.delayed(const Duration(seconds: 2));
      final announcement = await authServices.fetchAnnouncement();
      emit(AnnouncementSuccessState(announcement: announcement));
    }catch(e){
      emit(AnnouncementFailedState(error: e.toString()));
    }
  }
}
