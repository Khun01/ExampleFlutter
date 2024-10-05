part of 'hk_status_bloc.dart';

sealed class HkStatusEvent extends Equatable {
  const HkStatusEvent();

  @override
  List<Object> get props => [];
}

class HkStatusFetchDataEvent extends HkStatusEvent {}
