import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_duty_event.dart';
part 'delete_duty_state.dart';

class DeleteDutyBloc extends Bloc<DeleteDutyEvent, DeleteDutyState> {
  DeleteDutyBloc() : super(DeleteDutyInitial()) {
    on<DeleteDutyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
