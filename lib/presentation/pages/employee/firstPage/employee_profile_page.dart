import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_event.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_state.dart';
import 'package:help_isko/presentation/widgets/my_dialog.dart';
import 'package:ionicons/ionicons.dart';

class EmployeeProfilePage extends StatelessWidget {
  const EmployeeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataBloc()..add(LoadUserData(role: 'Employee')),
      child: BlocConsumer<UserDataBloc, UserDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UserDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserDataLoaded) {
            return Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverLayoutBuilder(
                      builder: (BuildContext context, constraints) {
                        final scrolled = constraints.scrollOffset > 50;
                        return SliverAppBar(
                          pinned: true,
                          automaticallyImplyLeading: false,
                          expandedHeight: 250,
                          collapsedHeight: 65,
                          backgroundColor: const Color(0xFF6BB577),
                          flexibleSpace: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 250,
                            decoration: BoxDecoration(
                              color: scrolled
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : const Color(0xFF6BB577),
                              boxShadow: scrolled
                                  ? [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: const Offset(0.0, 10.0),
                                          blurRadius: 10.0,
                                          spreadRadius: -6.0)
                                    ]
                                  : [],
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 300),
                                  left: scrolled ? 16 : 0,
                                  bottom: scrolled ? 16 : 0,
                                  child: AnimatedContainer(
                                    height: scrolled ? 35 : 310,
                                    width: scrolled
                                        ? 35
                                        : MediaQuery.of(context).size.width,
                                    duration: const Duration(milliseconds: 300),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        state.profile != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        scrolled ? 500 : 0),
                                                child: Image.network(
                                                    'http://192.168.100.212:8000/${state.profile}',
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Container()),
                                              )
                                            : Image.asset(
                                                'assets/images/profile_clicked.png',
                                                fit: BoxFit.cover,
                                                width: 30,
                                              ),
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                scrolled ? 550 : 0),
                                            color:
                                                Colors.black.withOpacity(0.2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 500),
                                  bottom: 16,
                                  left: scrolled ? 65 : 16,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AnimatedDefaultTextStyle(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        style: GoogleFonts.nunito(
                                            fontSize: scrolled ? 16 : 20,
                                            fontWeight: FontWeight.bold,
                                            color: scrolled
                                                ? const Color(0xFF3B3B3B)
                                                : const Color(0xFFFCFCFC)),
                                        child: Text(state.name ?? ''),
                                      ),
                                      AnimatedDefaultTextStyle(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        style: GoogleFonts.nunito(
                                            fontSize: scrolled ? 11 : 14,
                                            color: scrolled
                                                ? const Color(0xCC3B3B3B)
                                                : const Color(0xCCFCFCFC)),
                                        child: Text(state.idNumber ?? ''),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 16,
                                  bottom: -30,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        opacity: scrolled ? 0 : 1,
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF6BB577),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFFFCFCFC),
                                                  width: 2)),
                                        ),
                                      ),
                                      AnimatedPositioned(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        top: scrolled ? -65 : 0,
                                        bottom: 0,
                                        left: 6,
                                        right: scrolled ? -35 : 0,
                                        child: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) =>
                                                    const MyDialog(
                                                        role: 'Employee'));
                                          },
                                          icon: Icon(Ionicons.log_out,
                                              color: scrolled
                                                  ? const Color(0xFF3B3B3B)
                                                  : const Color(0xFFFCFCFC),
                                              size: scrolled ? 30 : 30),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 16,
                                  left: 16,
                                  right: 16,
                                  child: AnimatedOpacity(
                                    opacity: scrolled ? 0 : 1,
                                    duration: const Duration(milliseconds: 300),
                                    child: Row(
                                      children: [
                                        Text(
                                          'My Profile',
                                          style: GoogleFonts.nunito(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFFFCFCFC)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Person Details',
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6BB577)),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Birthday',
                                    style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF3B3B3B),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Contact Number',
                                    style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF3B3B3B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    state.birthday ?? "N/A",
                                    style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      color: const Color(0xFF3B3B3B),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    state.contactNumber ?? "N/A",
                                    style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      color: const Color(0xFF3B3B3B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 1125),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is UserDataError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
