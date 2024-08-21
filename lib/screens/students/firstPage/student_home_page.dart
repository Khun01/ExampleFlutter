import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/bloc/logout/logout_bloc.dart';
import 'package:help_isko/bloc/logout/logout_event.dart';
import 'package:help_isko/bloc/logout/logout_state.dart';
import 'package:help_isko/services/auth_services.dart';
import 'package:help_isko/services/global.dart';
import 'package:help_isko/services/storage.dart';
import 'package:help_isko/landing_page.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  String? token;
  String? name;

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  Future<void> loadToken() async {
    final userData = await Storage.getUserData();
    setState(() {
      token = userData['token'];
      name = userData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutBloc(
        authServices: AuthServices(apiUrl: baseUrl)
      ),
      child: Scaffold(
        body: BlocListener<LogoutBloc, LogoutState>(
          listener: (context, state){
            if(state is LogoutFailure){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error))
              );
            }else if(state is LogoutSuccess){
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => const LandingPage())
              );
            }
          },
          child: BlocBuilder<LogoutBloc, LogoutState>(
            builder: (context, state){
              return SafeArea(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Home Page',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        'Name: $name',
                        style: const TextStyle(fontSize: 30, color: Colors.black),
                      ),
                      Text(
                        'User Token: $token',
                        style:
                          const TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      const SizedBox(height: 20),
                      state is LogoutLoading ? const CircularProgressIndicator() :
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<LogoutBloc>(context).add(
                            LogoutButtonPressed()
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.black)
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 13),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                        )
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.black)
                        ), 
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 13),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: const Text(
                            'Duties',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                        )
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.black)
                        ), 
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 13),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: const Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                        )
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
