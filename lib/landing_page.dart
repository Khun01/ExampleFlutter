import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/bloc/login/login_bloc.dart';
import 'package:help_isko/bloc/login/login_event.dart';
import 'package:help_isko/bloc/login/login_state.dart';
import 'package:help_isko/components/my_text_field.dart';
import 'package:help_isko/services/auth_services.dart';
import 'package:help_isko/services/global.dart';
import 'package:help_isko/screens/students/firstPage/student_home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authServices: AuthServices(apiUrl: baseUrl)
      ),
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state){
            if(state is LoginFailure){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error))
              );
            } else if(state is LoginSuccess){
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => const StudentHomePage())
              );
            }
          },
          builder: (context, state){
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 50),
                    MyTextField(
                      controller: email, 
                      icon: const Icon(Icons.person), 
                      hintText: 'Email', 
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: password, 
                      icon: const Icon(Icons.lock), 
                      hintText: 'Password', 
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    state is LoginLoading ? const CircularProgressIndicator() :
                    ElevatedButton(
                      onPressed: (){
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginButtonPressed(
                            email: email.text, 
                            password: password.text
                          )
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.black)
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(13),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      )
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
