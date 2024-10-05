// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'duties_bloc.dart';

sealed class DutiesEvent extends Equatable {
  const DutiesEvent();

  @override
  List<Object> get props => [];
}

class DutiesAvailableFetch extends DutiesEvent {}

class DutiesAcceptEvent extends DutiesEvent {
  final int id;
  const DutiesAcceptEvent({
    required this.id,
  });
}
