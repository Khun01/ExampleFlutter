part of 'posted_duty_info_bloc.dart';

sealed class PostedDutyInfoEvent extends Equatable {
  const PostedDutyInfoEvent();

  @override
  List<Object> get props => [];
}

class PostedDutyInfoLoadedEvent extends PostedDutyInfoEvent {}
