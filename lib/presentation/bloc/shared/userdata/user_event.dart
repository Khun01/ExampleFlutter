import 'package:equatable/equatable.dart';

abstract class UserDataEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUserData extends UserDataEvent {
  final String role;

  LoadUserData({required this.role});
}