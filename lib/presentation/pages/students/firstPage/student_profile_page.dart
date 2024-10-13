import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_event.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_state.dart';
import 'package:help_isko/presentation/widgets/my_dialog.dart';
import 'package:help_isko/presentation/widgets/my_profile_page_text.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:ionicons/ionicons.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataBloc()..add(LoadUserData(role: 'Student')),
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
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            offset: const Offset(0.0, 10.0),
                                            blurRadius: 10.0,
                                            spreadRadius: -6.0)
                                      ]
                                    : []),
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
                                                  '$profileUrl${state.profile}',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: scrolled
                                                        ? Image.asset(
                                                            'assets/images/profile_clicked.png',
                                                          )
                                                        : null,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                margin:
                                                    const EdgeInsets.all(14),
                                                child: Image.asset(
                                                  'assets/images/profile_clicked.png',
                                                ),
                                              ),
                                        AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        scrolled ? 550 : 0),
                                                color: Colors.black
                                                    .withOpacity(0.2))),
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
                                                        role: 'Student'));
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
                            const EdgeInsets.only(top: 8, left: 16, right: 16),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Campus',
                              style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0x803B3B3B)),
                            ),
                            Text(
                              'Dagupan Campus',
                              style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)),
                            ),
                            const Divider(color: Color(0x303B3B3B)),
                            MyProfilePageText(
                              title1: 'Course',
                              body1: state.course ?? 'N/A',
                              title2: 'Learning Modality',
                              body2: state.learningModality ?? 'N/A',
                            ),
                            const Divider(color: Color(0x303B3B3B)),
                            MyProfilePageText(
                              title1: 'Curriculum',
                              body1:
                                  '${state.college} - ${state.course} - ${state.department} - 22 - 23',
                              title2: 'Semester',
                              body2: state.semester ?? 'N/A',
                            ),
                            const Divider(color: Color(0x303B3B3B)),
                            const SizedBox(height: 12),
                            Text(
                              'Person Details',
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6BB577)),
                            ),
                            const SizedBox(height: 6),
                            MyProfilePageText(
                              title1: 'Student Name',
                              body1: state.name ?? 'N/A',
                              title2: 'Student Number',
                              body2: state.idNumber ?? 'N/A',
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'College',
                                      style: GoogleFonts.nunito(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF3B3B3B)),
                                    ),
                                    Text(
                                      state.college ?? 'N/A',
                                      style: GoogleFonts.nunito(
                                          fontSize: 12,
                                          color: const Color(0xFF3B3B3B)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            MyProfilePageText(
                              title1: "Father's Name",
                              body1: state.fatherName ?? 'N/A',
                              title2: "Mother's Name",
                              body2: state.motherName ?? 'N/A',
                            ),
                            const Divider(color: Color(0x303B3B3B)),
                            const SizedBox(height: 12),
                            Text(
                              'Contact Details',
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6BB577)),
                            ),
                            const SizedBox(height: 6),
                            // para sa email ito
                            MyProfilePageText(
                              title1: "Email",
                              body1: state.fatherName ?? 'N/A',
                              title2: "Student Mobile No.",
                              body2: state.contactNumber ?? 'N/A',
                            ),
                            const SizedBox(height: 12),
                            MyProfilePageText(
                              title1: "Father's Mobile No.",
                              body1: state.fatherContactNumber ?? 'N/A',
                              title2: "Mother's Contact No.",
                              body2: state.motherContactNumber ?? 'N/A',
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Emergency Person Contact Details',
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6BB577)),
                            ),
                            const SizedBox(height: 6),
                            MyProfilePageText(
                              title1: "Person Name",
                              body1: state.emergencyPersonName ?? 'N/A',
                              title2: "Relation",
                              body2: state.relation ?? 'N/A',
                            ),
                            const SizedBox(height: 12),
                            MyProfilePageText(
                              title1: "Address",
                              body1: state.emergencyAddress ?? 'N/A',
                              title2: "Person's Mobile No.",
                              body2: state.emergencyContactNumber ?? 'N/A',
                            ),
                            const Divider(color: Color(0x303B3B3B)),
                            const SizedBox(height: 12),
                            Text(
                              'Current Address',
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6BB577)),
                            ),
                            const SizedBox(height: 6),
                            MyProfilePageText(
                              title1: "Address",
                              body1: state.currentAddress ?? 'N/A',
                              title2: "Country",
                              body2: state.currentCountry ?? 'N/A',
                            ),
                            const SizedBox(height: 12),
                            MyProfilePageText(
                              title1: "Province",
                              body1: state.currentProvince ?? 'N/A',
                              title2: "City",
                              body2: state.currentCity ?? 'N/A',
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Permanent Address',
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6BB577)),
                            ),
                            const SizedBox(height: 6),
                            MyProfilePageText(
                              title1: "Address",
                              body1: state.permanentAddress ?? 'N/A',
                              title2: "Country",
                              body2: state.permanentCountry ?? 'N/A',
                            ),
                            const SizedBox(height: 12),
                            MyProfilePageText(
                              title1: "Province",
                              body1: state.permanentProvince ?? 'N/A',
                              title2: "City",
                              body2: state.permanentCity ?? 'N/A',
                            ),
                            const Divider(color: Color(0x303B3B3B)),
                            const SizedBox(height: 12),
                            Text(
                              'Duty Details',
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6BB577)),
                            ),
                            const SizedBox(height: 6),
                            MyProfilePageText(
                              title1: "Active Duty",
                              body1: state.activeDutyCount ?? 'N/A',
                              title2: "Completed Duty",
                              body2: state.completedDutyCount ?? 'N/A',
                            ),
                            const SizedBox(height: 6),
                            MyProfilePageText(
                              title1: "Total Duty",
                              body1: state.totalDutyCount ?? 'N/A',
                              title2: 'Duty Hours Remaining',
                              body2: '${state.dutyHoursRemaining ?? 'N/A'} hours',
                            ),
                            const SizedBox(height: 86),
                          ],
                        ),
                      ),
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
