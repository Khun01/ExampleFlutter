import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_duty_event.dart';
part 'update_duty_state.dart';

class UpdateDutyBloc extends Bloc<UpdateDutyEvent, UpdateDutyState> {
  UpdateDutyBloc() : super(UpdateDutyInitial()) {
    on<UpdateDutyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
