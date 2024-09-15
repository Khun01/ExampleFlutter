import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/data/prof_duty.dart';
import 'package:help_isko/repositories/api_repositories.dart';

part 'posted_duties_event.dart';
part 'posted_duties_state.dart';

class PostedDutiesBloc extends Bloc<PostedDutiesEvent, PostedDutiesState> {
  final ApiRepositories apiRepositories;
  PostedDutiesBloc({required this.apiRepositories}) : super(PostedDutiesInitial()) {
    on<FetchDuty>(fetchDuty);
  }

  FutureOr<void> fetchDuty(FetchDuty event, Emitter<PostedDutiesState> emit) async{
     emit(PostedDutiesLoadingState());
    try{
      await Future.delayed(const Duration(seconds: 2));
      final duty = await apiRepositories.fetchPostedDuties();
      emit(PostedDutiesSuccessState(duty: duty));
    }catch(e){
      emit(PostedDutiestFailedState(error: e.toString()));
    }
  }
}
