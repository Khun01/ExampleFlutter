part of 'add_duty_bloc.dart';

sealed class AddDutyState extends Equatable {
  const AddDutyState();
  
  @override
  List<Object> get props => [];
}

final class AddDutyInitial extends AddDutyState {}
