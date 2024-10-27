import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/duty/postedDutyInfo/posted_duty_info_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/duty/show/posted_duties_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_event.dart';
import 'package:help_isko/presentation/bloc/shared/userdata/user_state.dart';
import 'package:help_isko/presentation/cards/duty_card/completed_duties_card.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/dutyInfoPage/posted_duty_info_page.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_recent_activity_loading_indicator.dart';
import 'package:help_isko/presentation/widgets/my_dialog.dart';
import 'package:help_isko/presentation/widgets/my_profile_page_text.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/services/employee/duty/duty_services.dart';
import 'package:ionicons/ionicons.dart';

class EmployeeProfilePage extends StatelessWidget {
  const EmployeeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final PostedDutiesBloc postedDutiesBloc =
        PostedDutiesBloc(dutyRepository: DutyServices(baseUrl: baseUrl))
          ..add(FetchCompletedDuty());
    final PostedDutyInfoBloc postedDutyInfoBloc =
        PostedDutyInfoBloc(dutyRepository: DutyServices(baseUrl: baseUrl))
          ..add(PostedDutyInfoLoadedEvent());
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
                        final scrolled = constraints.scrollOffset > 100;
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
                      child:
                          BlocConsumer<PostedDutyInfoBloc, PostedDutyInfoState>(
                        bloc: postedDutyInfoBloc,
                        listener: (context, state) {},
                        builder: (context, state) {
                          String activeDuty = '0';
                          String confirmedDuty = '0';
                          String postedDuty = '0';
                          if (state is FetchPostedDutyInfoSuccessState) {
                            activeDuty = state.dutyInfo.activeDuty.toString();
                            confirmedDuty =
                                state.dutyInfo.confirmedDuty.toString();
                            postedDuty = state.dutyInfo.postedDuty.toString();
                          } else if (state is FetchPostedDutyInfoFailedState) {
                            activeDuty = 'Error';
                            confirmedDuty = 'Error';
                            postedDuty = 'Error';
                          }
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Posted Duty Information',
                                  style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF6BB577),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color(0x1A6BB577),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: const Color(0x1A3B3B3B),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/duty_dialog_images/checked.png',
                                              height: 50,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Confirmed Duty',
                                              style: GoogleFonts.nunito(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0x803B3B3B),
                                              ),
                                            ),
                                            Text(
                                              confirmedDuty.toString(),
                                              style: GoogleFonts.nunito(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF3B3B3B),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color(0x1A6BB577),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: const Color(0x1A3B3B3B),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/active_duty_employee_profile.png',
                                              height: 50,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Active Duty',
                                              style: GoogleFonts.nunito(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0x803B3B3B),
                                              ),
                                            ),
                                            Text(
                                              activeDuty.toString(),
                                              style: GoogleFonts.nunito(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF3B3B3B),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color(0x1A6BB577),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: const Color(0x1A3B3B3B),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/posted_duty_employee_profile.png',
                                              height: 50,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Posted Duty',
                                              style: GoogleFonts.nunito(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0x803B3B3B),
                                              ),
                                            ),
                                            Text(
                                              postedDuty.toString(),
                                              style: GoogleFonts.nunito(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF3B3B3B),
                                              ),
                                            )
                                          ],
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
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Person Details',
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF6BB577),
                              ),
                            ),
                            const SizedBox(height: 8),
                            MyProfilePageText(
                              title1: 'Birthday',
                              body1: state.birthday ?? 'N/A',
                              title2: 'Contact Number',
                              body2: state.contactNumber ?? 'N/A',
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8),
                        child: Text(
                          'Completed Duties',
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF6BB577),
                          ),
                        ),
                      ),
                    ),
                    BlocConsumer<PostedDutiesBloc, PostedDutiesState>(
                      bloc: postedDutiesBloc,
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is PostedDutiesLoadingState) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return const MyRecentActivityLoadingIndicator();
                              },
                              childCount: 15,
                            ),
                          );
                        } else if (state is PostedDutiestFailedState) {
                          return SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: Text(
                                'No completed duty yet',
                                style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B)),
                              ),
                            ),
                          );
                        } else if (state is PostedDutiesSuccessState) {
                          return LiveSliverList(
                            controller: scrollController,
                            showItemDuration: const Duration(milliseconds: 300),
                            itemCount: state.duty.length,
                            itemBuilder: (context, index, animation) {
                              final completedDuties = state.duty[index];
                              return FadeTransition(
                                opacity: Tween<double>(
                                  begin: 0,
                                  end: 1,
                                ).animate(animation),
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, -0.1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: context.read<MessageBloc>(),
                                            child: PostedDutyInfoPage(
                                              profDuty: completedDuties,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: CompletedDutiesCard(
                                      building: completedDuties.building ?? '',
                                      message: completedDuties.message ?? '',
                                      dutyStatus:
                                          completedDuties.dutyStatus ?? '',
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const SliverFillRemaining(
                            hasScrollBody: false,
                            child: SizedBox(),
                          );
                        }
                      },
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 78,
                      ),
                    )
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
