part of 'duties_bloc.dart';

sealed class DutiesState extends Equatable {
  const DutiesState();
  
  @override
  List<Object> get props => [];
}

final class DutiesInitial extends DutiesState {}
