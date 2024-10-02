// lib/components/custom_app_bar.dart
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_event.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_state.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/hk_student_list_page.dart';
import 'package:ionicons/ionicons.dart';
import 'package:uicons/uicons.dart';

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
                    FadeInLeft(
                      duration: const Duration(milliseconds: 700),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xFFA3D9A5),
                        child: ClipOval(
                          child: state.profile != null
                              ? Image.network(
                                  'http://192.168.100.212:8000/${state.profile}',
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    'assets/images/profile_clicked.png',
                                    fit: BoxFit.cover,
                                    width: 30,
                                  ),
                                )
                              : Image.asset(
                                  'assets/images/profile_clicked.png',
                                  fit: BoxFit.cover,
                                  width: 30,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 700),
                      child: Column(
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
                    ),
                    const Spacer(),
                    role == 'Employee'
                        ? FadeInRight(
                            duration: const Duration(milliseconds: 700),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                        value: context.read<MessageBloc>(),
                                        child: const HkStudentListPage(),
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(UIcons.regularRounded.users)))
                        : FadeInRight(
                            duration: const Duration(milliseconds: 700),
                            child: const Icon(Ionicons.document_text,
                                color: Color(0xFF3B3B3B)),
                          ),
                    const SizedBox(width: 16),
                    FadeInRight(
                      duration: const Duration(milliseconds: 700),
                      child: Icon(UIcons.regularRounded.bell,
                          color: const Color(0xFF3B3B3B)),
                    ),
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
