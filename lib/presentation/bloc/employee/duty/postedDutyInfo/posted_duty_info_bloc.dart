import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/models/employee/posted_duty_info.dart';
import 'package:help_isko/repositories/employee/duty/duty_repository.dart';

part 'posted_duty_info_event.dart';
part 'posted_duty_info_state.dart';

class PostedDutyInfoBloc
    extends Bloc<PostedDutyInfoEvent, PostedDutyInfoState> {
  final DutyRepository dutyRepository;
  PostedDutyInfoBloc({required this.dutyRepository})
      : super(PostedDutyInfoInitial()) {
    on<PostedDutyInfoLoadedEvent>(postedDutyInfoLoadedEvent);
  }

  FutureOr<void> postedDutyInfoLoadedEvent(PostedDutyInfoLoadedEvent event,
      Emitter<PostedDutyInfoState> emit) async {
    emit(FetchPostedDutyInfoLoadingState());
    try {
      final response = await dutyRepository.fetchPostedDutyInfo();
      emit(FetchPostedDutyInfoSuccessState(dutyInfo: response));
    } catch (e) {
      emit(FetchPostedDutyInfoFailedState(error: e.toString()));
    }
  }
}
