part of 'hk_status_bloc.dart';

sealed class HkStatusState extends Equatable {
  const HkStatusState();

  @override
  List<Object> get props => [];
}

final class HkStatusInitial extends HkStatusState {}

class HkStatusFetchLoading extends HkStatusState {}

class HkStatusFetchSuccess extends HkStatusState {
  final int percentage;

  const HkStatusFetchSuccess({required this.percentage});
}

class HkStatusFetchFailed extends HkStatusState {
  final String errorMessage;

  const HkStatusFetchFailed({required this.errorMessage});
}
