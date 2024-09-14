import 'package:equatable/equatable.dart';

abstract class UserDataState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataLoaded extends UserDataState {
  final String? token;
  final String? name;
  final String? firstName;
  final String? employeeNumber;

  UserDataLoaded({this.token, this.name, this.firstName, required this.employeeNumber});
}

class UserDataError extends UserDataState {
  final String message;

  UserDataError({
    required this.message
  });
}
