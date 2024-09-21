import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_duty_event.dart';
part 'add_duty_state.dart';

class AddDutyBloc extends Bloc<AddDutyEvent, AddDutyState> {
  AddDutyBloc() : super(AddDutyInitial()) {
    on<AddDutyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
