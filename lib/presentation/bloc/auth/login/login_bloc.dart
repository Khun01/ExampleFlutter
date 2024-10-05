import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/presentation/bloc/auth/login/login_event.dart';
import 'package:help_isko/presentation/bloc/auth/login/login_state.dart';
import 'package:help_isko/repositories/api_repositories.dart';
import 'package:help_isko/repositories/pusher_repository.dart';
import 'package:help_isko/repositories/storage/employee_storage.dart';
import 'package:help_isko/repositories/storage/student_storage.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiRepositories apiRepositories;
  final PusherRepository _pusher = PusherRepository();

  LoginBloc({required this.apiRepositories}) : super(LoginState.initial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPassChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<CheckLoginStatusEvent>(_checkLoginStatus);
  }

  void _checkLoginStatus(
      CheckLoginStatusEvent event, Emitter<LoginState> emit) async {
    _pusher.pusherConnect();
    try {
      emit(state.copyWith(
          isSuccess: false, hasFailed: false, isSubmitting: true));
      if (event.role == 'Student') {
        emit(state.copyWith(isSubmitting: true));
        try {
          final userData = await StudentStorage.getData();
          final token = userData['studToken'];
          final id = userData['user_id'];
          log('The student token: $token');
          if (token != null && token.isNotEmpty) {
            await Future.delayed(const Duration(seconds: 2));
            emit(state.copyWith(isSuccess: true, isSubmitting: false));
            _pusher.subscribeChannel(int.parse(id!));
          } else {
            log('dont have a token Employee');
            emit(state.copyWith(hasFailed: true, isSubmitting: false));
          }
        } catch (e) {
          emit(state.copyWith(failureMessage: e.toString()));
        }
      }
      if (event.role == 'Employee') {
        emit(state.copyWith(isSubmitting: true));
        try {
          final userData = await EmployeeStorage.getData();
          final token = userData['employeeToken'];
          final id = userData['user_id'];
          log('The Employee token: $token');

          if (token != null && token.isNotEmpty) {
            await Future.delayed(const Duration(seconds: 2));
            emit(state.copyWith(isSuccess: true, isSubmitting: false));
            _pusher.subscribeChannel(int.parse(id!));
          } else {
            log('dont have a token Employee');
            emit(state.copyWith(hasFailed: true, isSubmitting: false));
          }
        } catch (e) {
          emit(state.copyWith(failureMessage: e.toString()));
        }
      }
    } catch (e) {
      emit(state.copyWith(
          failureMessage: 'Network Error',
          hasFailed: true,
          isSubmitting: false));
    }
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        email: event.email,
        isEmailValid: _validateEmail(event.email),
        hasFailed: false,
        failureMessage: null));
  }

  void _onPasswordChanged(LoginPassChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        password: event.password,
        isPasswordValid: _validatePassword(event.password),
        hasFailed: false,
        failureMessage: null));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.email.isNotEmpty || state.password.isNotEmpty) {
      if (state.isFormValid) {
        emit(state.copyWith(isSubmitting: true));
        try {
          if (event.role == 'Employee') {
            await Future.delayed(const Duration(seconds: 2));
            final response = await apiRepositories.loginEmployee(
                state.email, state.password);
            final statusCode = response['statusCode'];
            final responseData = response['data'];
            if (statusCode == 200) {
              final String token = responseData['token'];
              final String name = responseData['name'];

              final Map<String, dynamic> user = responseData['user'];
              final String id = user['id'].toString();
              final String firstName = user['first_name'];
              final String lastName = user['last_name'];
              final String birthday = user['birthday'];
              final String contactNumber = user['contact_number'];
              final String idNumber = user['employee_number'];
              final String profileImg = user['profile_img'] ?? '';
              final String userId = user['user_id'].toString();

              await EmployeeStorage.saveData(
                id: id,
                firstName: firstName,
                lastName: lastName,
                birthday: birthday,
                contactNumber: contactNumber,
                idNumber: idNumber,
                profileImg: profileImg,
                userId: userId,
                employeeToken: token,
                fullName: name,
              );

              log('Response data: $user');
              emit(state.copyWith(isSuccess: true, isSubmitting: false));
            } else {
              String errorMessage;
              switch (statusCode) {
                case 401:
                  errorMessage = 'Email and password do not match our records';
                  break;
                case 403:
                  errorMessage = 'You are not a employee';
                  break;
                default:
                  log('The status Code is $statusCode');
                  errorMessage = 'User not found';
              }
              emit(state.copyWith(
                  hasFailed: true,
                  isSubmitting: false,
                  failureMessage: errorMessage));
            }
          }
          if (event.role == 'Student') {
            await Future.delayed(const Duration(seconds: 2));
            final response =
                await apiRepositories.loginStud(state.email, state.password);
            final statusCode = response['statusCode'];
            final responseData = response['data'];
            if (statusCode == 200) {
              final String token = responseData['token'];
              final String name = responseData['name'];

              final Map<String, dynamic> user = responseData['user'];
              final String id = user['id'].toString();
              final String firstName = user['first_name'];
              final String lastName = user['last_name'];
              final String birthday = user['birthday'];
              final String contactNumber = user['contact_number'];
              final String idNumber = user['student_number'];
              final String profileImg = user['profile_img'] ?? '';
              final String userId = user['user_id'].toString();

              final String college = user['college'];
              final String course = user['course'];
              final String department = user['department'];
              final String semester = user['semester'];
              final String learningModality = user['learning_modality'];

              final String fatherName = user['father_name'];
              final String fatherContactNumber = user['father_contact_number'];
              final String motherName = user['mother_name'];
              final String motherContactNumber = user['mother_contact_number'];

              final String currentAddress = user['current_address'];
              final String currentProvince = user['current_province'];
              final String currentCountry = user['current_country'];
              final String currentCity = user['current_city'];

              final String permanentAddress = user['permanent_address'];
              final String permanentProvince = user['permanent_province'];
              final String permanentCountry = user['permanent_country'];
              final String permanentCity = user['permanent_city'];

              final String emergencyPersonName = user['emergency_person_name'];
              final String emergencyAddress = user['emergency_address'];
              final String relation = user['relation'];
              final String emergencyContactNumber =
                  user['emergency_contact_number'];

              await StudentStorage.saveData(
                id: id,
                firstName: firstName,
                lastName: lastName,
                birthday: birthday,
                contactNumber: contactNumber,
                idNumber: idNumber,
                profileImg: profileImg,
                userId: userId,
                studToken: token,
                fullName: name,
                college: college,
                course: course,
                department: department,
                semester: semester,
                learningModality: learningModality,
                fatherName: fatherName,
                fatherContactNumber: fatherContactNumber,
                motherName: motherName,
                motherContactNumber: motherContactNumber,
                currentAddress: currentAddress,
                currentProvince: currentProvince,
                currentCountry: currentCountry,
                currentCity: currentCity,
                permanentAddress: permanentAddress,
                permanentProvince: permanentProvince,
                permanentCountry: permanentCountry,
                permanentCity: permanentCity,
                emergencyPersonName: emergencyPersonName,
                emergencyAddress: emergencyAddress,
                relation: relation,
                emergencyContactNumber: emergencyContactNumber,
              );

              log('Response data: $user');
              emit(state.copyWith(isSuccess: true, isSubmitting: false));
            } else {
              String errorMessage;
              switch (statusCode) {
                case 401:
                  errorMessage = 'Email and password do not match our records';
                  break;
                case 403:
                  errorMessage = 'You are not a student';
                  break;
                default:
                  log('The status Code is $statusCode');
                  errorMessage = 'User not found';
              }
              emit(state.copyWith(
                  hasFailed: true,
                  isSubmitting: false,
                  failureMessage: errorMessage));
            }
          }
        } catch (e) {
          log('The response is: $e');
          emit(state.copyWith(
              isSubmitting: false,
              hasFailed: true,
              failureMessage: 'Network Error'));
        }
      } else {
        emit(state.copyWith(
          isEmailValid: state.isEmailNotEmpty && state.isEmailValid,
          isPasswordValid: state.isPasswordNotEmpty && state.isPasswordValid,
        ));
      }
    } else {
      emit(state.copyWith(failureMessage: 'Please put your account first'));
    }
  }

  bool _validateEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        caseSensitive: false);
    return regex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length > 6;
  }
}
