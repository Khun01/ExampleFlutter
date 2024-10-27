part of 'posted_duty_info_bloc.dart';

sealed class PostedDutyInfoState extends Equatable {
  const PostedDutyInfoState();
  
  @override
  List<Object> get props => [];
}

final class PostedDutyInfoInitial extends PostedDutyInfoState {}

class FetchPostedDutyInfoLoadingState extends PostedDutyInfoState{}

class FetchPostedDutyInfoSuccessState extends PostedDutyInfoState{
  final PostedDutyInfo dutyInfo;

  const FetchPostedDutyInfoSuccessState({required this.dutyInfo});
}

class FetchPostedDutyInfoFailedState extends PostedDutyInfoState{
  final String error;

  const FetchPostedDutyInfoFailedState({required this.error});
}