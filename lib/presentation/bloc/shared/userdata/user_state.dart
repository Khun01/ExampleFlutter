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

  final String? emergencyPersonName;
  final String? emergencyContactNumber;
  final String? emergencyAddress;
  final String? relation;

  final String? currentAddress;
  final String? currentProvince;
  final String? currentCountry;
  final String? currentCity;

  final String? permanentAddress;
  final String? permanentProvince;
  final String? permanentCountry;
  final String? permanentCity;

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
    this.emergencyPersonName,
    this.emergencyContactNumber,
    this.emergencyAddress,
    this.relation,
    this.currentAddress,
    this.currentProvince,
    this.currentCountry,
    this.currentCity,
    this.permanentAddress,
    this.permanentProvince,
    this.permanentCountry,
    this.permanentCity,
  });
}

class UserDataError extends UserDataState {
  final String message;

  UserDataError({required this.message});
}
