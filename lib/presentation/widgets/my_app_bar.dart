// lib/components/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_event.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_state.dart';
import 'package:ionicons/ionicons.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String role;

  const MyAppBar({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataBloc()..add(LoadUserData(role: role)),
      child: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          if (state is UserDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserDataLoaded) {
            return Container(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color(0x80A3D9A5),
                      radius: 25,
                      child: Icon(Icons.person),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          state.firstName ?? 'N/A',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3B3B3B),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    role == 'Employee'
                        ? const Icon(Ionicons.people, color: Color(0xFF3B3B3B))
                        : const Icon(Ionicons.document_text, color: Color(0xFF3B3B3B)),
                    const SizedBox(width: 10),
                    const Icon(Ionicons.notifications,
                        color: Color(0xFF3B3B3B)),
                  ],
                ));
          } else if (state is UserDataError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
