import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/presentation/bloc/auth/logout/logout_event.dart';
import 'package:help_isko/presentation/bloc/auth/logout/logout_state.dart';
import 'package:help_isko/repositories/api_repositories.dart';
import 'package:help_isko/repositories/storage.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState>{
  final ApiRepositories apiRepositories; 
  LogoutBloc({required this.apiRepositories}) : super(LogoutInitial()){
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  void _onLogoutButtonPressed(LogoutButtonPressed event, Emitter<LogoutState> emit) async{
    emit(LogoutLoading());
    try{
      await Future.delayed(const Duration(seconds: 2));
      final statusCode = await apiRepositories.logout(event.role);
      if(statusCode == 200){
        await Storage.deleteData();
        emit(LogoutSuccess());
      }else {
        emit(LogoutFailure(error: 'Logout failed with status code: $statusCode'));
      }
    }catch(error){
      log('Logout Failed: ${error.toString()}');
      emit(LogoutFailure(error: error.toString()));
    }
  }
}