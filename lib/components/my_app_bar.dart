import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/bloc/userdata/user_bloc.dart';
import 'package:help_isko/bloc/userdata/user_event.dart';
import 'package:help_isko/bloc/userdata/user_state.dart';
import 'package:help_isko/components/my_icon_button_app_bar.dart';

class MyAppBar extends StatefulWidget {
  final String selectedRole;

  const MyAppBar({
    super.key,
    required this.selectedRole
  });

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataBloc()..add(LoadUserData()),
      child: Container(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 25),
        child: BlocBuilder<UserDataBloc, UserDataState>(
          builder: (context, userDataState){
            if(userDataState is UserDataLoading){
              return const Center(child: CircularProgressIndicator());
            }else if(userDataState is UserDataLoaded){
              return Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0x80A3D9A5),
                    radius: 25,
                    child: Icon(
                      Icons.person
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0x803B3B3B),
                        ),
                      ),
                      Text(
                        userDataState.name ?? 'N/A',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  MyIconButtonAppBar(
                    selectedRole: widget.selectedRole,
                  )
                ],
              );
            }else if (userDataState is UserDataError) {
              return Center(child: Text(userDataState.message));
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
