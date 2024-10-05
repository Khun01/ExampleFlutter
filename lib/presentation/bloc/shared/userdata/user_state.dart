import 'package:equatable/equatable.dart';

abstract class UserDataState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataLoaded extends UserDataState {
  final String? profile;
  final String? token;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? idNumber;
  final String? birthday;
  final String? contactNumber;
  final String? college;
  final String? course;
  final String? department;
  final String? semester;
  final String? learningModality;
  final String? fatherName;
  final String? fatherContactNumber;
  final String? motherName;
  final String? motherContactNumber;

  UserDataLoaded({
    this.profile,
    this.token,
    this.name,
    this.firstName,
    this.lastName,
    this.idNumber,
    this.birthday,
    this.contactNumber,
    this.college,
    this.course,
    this.department,
    this.semester,
    this.learningModality,
    this.fatherName,
    this.fatherContactNumber,
    this.motherName,
    this.motherContactNumber,
  });
}

class UserDataError extends UserDataState {
  final String message;

  UserDataError({required this.message});
}
