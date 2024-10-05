import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_isko/repositories/student/homepage/hk_status_repository.dart';

part 'hk_status_event.dart';
part 'hk_status_state.dart';

class HkStatusBloc extends Bloc<HkStatusEvent, HkStatusState> {
  final HkStatusRepository hkStatusRepository;
  HkStatusBloc({required this.hkStatusRepository}) : super(HkStatusInitial()) {
    on<HkStatusFetchDataEvent>(hkStatusFetchDataEvent);
  }

  FutureOr<void> hkStatusFetchDataEvent(
      HkStatusFetchDataEvent event, Emitter<HkStatusState> emit) async {
    emit(HkStatusFetchLoading());
    try {
      final percentage = await hkStatusRepository.getHkStatus();
      emit(HkStatusFetchSuccess(percentage: percentage));
    } catch (e) {
      emit(HkStatusFetchFailed(errorMessage: '$e'));
    }
  }
}
