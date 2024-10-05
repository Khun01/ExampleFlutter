import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'duties_event.dart';
part 'duties_state.dart';

class DutiesBloc extends Bloc<DutiesEvent, DutiesState> {
  DutiesBloc() : super(DutiesInitial()) {
    on<DutiesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
