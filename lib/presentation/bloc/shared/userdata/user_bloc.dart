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
        final contactNumber = userData['contactNumber'] ?? 'N/A';
        final college = userData['college'] ?? 'N/A';
        final course = userData['course'] ?? 'N/A';
        final department = userData['department'] ?? 'N/A';
        final semester = userData['semester'] ?? 'N/A';
        final learningModality = userData['learningModality'] ?? 'N/A';
        final fatherName = userData['fatherName'] ?? 'N/A';
        final fatherContactNumber = userData['fatherContactNumber'] ?? 'N/A';
        final motherName = userData['motherName'] ?? 'N/A';
        final motherContactNumber = userData['motherContactNumber'] ?? 'N/A';
        final profileImg = userData['profileImg'] ?? 'N/A';

        final emergencyPersonName = userData['emergencyPersonName'] ?? 'N/A';
        final emergencyAddress = userData['emergencyAddress'] ?? 'N/A';
        final relation = userData['relation'] ?? 'N/A';
        final emergencyContactNumber = userData['emergencyContactNumber'] ?? 'N/A';

        final currentAddress = userData['currentAddress'] ?? 'N/A';
        final currentProvince = userData['currentProvince'] ?? 'N/A';
        final currentCity = userData['currentCity'] ?? 'N/A';
        final currentCountry = userData['currentCountry'] ?? 'N/A';

        final permanentAddress = userData['permanentAddress'] ?? 'N/A';
        final permanentProvince = userData['permanentProvince'] ?? 'N/A';
        final permanentCity = userData['permanentCity'] ?? 'N/A';
        final permanentCountry = userData['permanentCountry'] ?? 'N/A';

        emit(UserDataLoaded(
          name: name,
          token: token,
          firstName: firstName,
          lastName: lastName,
          idNumber: idNumber,
          contactNumber: contactNumber,
          college: college,
          course: course,
          department: department,
          semester: semester,
          learningModality: learningModality,
          fatherName: fatherName,
          fatherContactNumber: fatherContactNumber,
          motherName: motherName,
          motherContactNumber: motherContactNumber,
          profile: profileImg,
          emergencyPersonName: emergencyPersonName,
          emergencyAddress: emergencyAddress,
          relation: relation,
          emergencyContactNumber: emergencyContactNumber,
          currentAddress: currentAddress,
          currentProvince: currentProvince,
          currentCity: currentCity,
          currentCountry: currentCountry,
          permanentAddress: permanentAddress,
          permanentProvince: permanentProvince,
          permanentCity: permanentCity,
          permanentCountry: permanentCountry,
        ));
      } else if (event.role == 'Employee') {
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
