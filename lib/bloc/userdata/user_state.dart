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

  UserDataLoaded({this.token, this.name});
}

class UserDataError extends UserDataState {
  final String message;

  UserDataError({
    required this.message
  });
}
