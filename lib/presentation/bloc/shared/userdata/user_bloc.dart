import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_event.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_state.dart';
import 'package:help_isko/repositories/storage/employee_storage.dart';
import 'package:help_isko/repositories/storage/student_storage.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(UserDataInitial()) {
    on<LoadUserData>(_onLoadUserData);
  }

  void _onLoadUserData(LoadUserData event, Emitter<UserDataState> emit) async {
    emit(UserDataLoading());
    try {
      if (event.role == 'Student') {
        final userData = await StudentStorage.getData();
        final name = userData['name'] ?? 'N/A';
        final token = userData['token'] ?? 'N/A';
        final firstName = userData['firstName'] ?? 'N/A';
        final lastName = userData['lastName'] ?? 'N/A';
        final idNumber = userData['idNumber'] ?? 'N/A';
        final college = userData['college'] ?? 'N/A';
        final course = userData['course'] ?? 'N/A';
        final department = userData['department'] ?? 'N/A';
        final semester = userData['semester'] ?? 'N/A';
        final learningModality = userData['learningModality'] ?? 'N/A';
        final fatherName = userData['fatherName'] ?? 'N/A';
        final fatherContactNumber = userData['fatherContactNumber'] ?? 'N/A';
        final motherName = userData['motherName'] ?? 'N/A';
        final motherContactNumber = userData['motherContactNumber'] ?? 'N/A';
        emit(UserDataLoaded(
            name: name,
            token: token,
            firstName: firstName,
            lastName: lastName,
            idNumber: idNumber,
            college: college,
            course: course,
            department: department,
            semester: semester,
            learningModality: learningModality,
            fatherName: fatherName,
            fatherContactNumber: fatherContactNumber,
            motherName: motherName,
            motherContactNumber: motherContactNumber));
      }else if(event.role == 'Employee'){
        final userData = await EmployeeStorage.getData();
        final name = userData['name'] ?? 'N/A';
        final token = userData['token'] ?? 'N/A';
        final firstName = userData['firstName'] ?? 'N/A';
        final idNumber = userData['idNumber'] ?? 'N/A';
        final birthday = userData['birthday'] ?? 'N/A';
        final contactNumber = userData['contactNumber'] ?? 'N/A';
        final profile = userData['profileImg'] ?? 'N/A';
        emit(UserDataLoaded(
            name: name,
            token: token,
            firstName: firstName,
            idNumber: idNumber,
            profile: profile,
            birthday: birthday,
            contactNumber: contactNumber));
      }
    } catch (e) {
      emit(UserDataError(message: e.toString()));
    }
  }
}
