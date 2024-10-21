import 'dart:developer';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/announcement/announcement_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/recentActivity/recent_activities_bloc.dart';
import 'package:help_isko/presentation/bloc/student/homepage/requested_duties/requested_duties_bloc.dart';
import 'package:help_isko/presentation/cards/shared/announcement_card.dart';
import 'package:help_isko/presentation/cards/duty_card/posted_duties_home.dart';
import 'package:help_isko/presentation/cards/shared/recent_activity_card.dart';
import 'package:help_isko/presentation/pages/students/secondPage/requested_for_duties_info_page.dart';
import 'package:help_isko/presentation/pages/students/secondPage/student_see_all_page.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_announcement_loading_indicator.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_posted_duties_home_page_loading.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_recent_activity_loading_indicator.dart';
import 'package:help_isko/presentation/widgets/my_announcemet_dialog.dart';
import 'package:help_isko/presentation/widgets/my_app_bar.dart';
import 'package:help_isko/presentation/widgets/studentDutyHours/my_duty_hours.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final PageController pageController = PageController();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: MyAppBar(role: "Student"),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 8),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                child: MyDutyHours(),
              ),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 16),
              child: Text(
                'Announcement',
                style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B)),
              ),
            )),
            BlocConsumer<AnnouncementBloc, AnnouncementState>(
              listener: (context, state) {
                if (state is AnnouncementFailedState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                  log('The error on announcement is: ${state.error}');
                }
              },
              builder: (context, state) {
                if (state is AnnouncementLoadingState) {
                  return const SliverToBoxAdapter(
                    child: SizedBox(
                        height: 163, child: MyAnnouncementLoadingIndicator()),
                  );
                } else if (state is AnnouncementSuccessState) {
                  if (state.announcement.isEmpty) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 163,
                        child: Center(
                          child: Text(
                            'Stay tuned for announcements!',
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B)),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 156,
                            child: PageView.builder(
                              controller: pageController,
                              itemBuilder: (context, index) {
                                final actualIndex =
                                    index % state.announcement.length;
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return MyAnnouncemetDialog(
                                              announcement: state
                                                  .announcement[actualIndex]);
                                        });
                                  },
                                  child: AnnouncementCard(
                                      heading: state
                                          .announcement[actualIndex].heading,
                                      description: state
                                          .announcement[actualIndex]
                                          .description,
                                      announcementImg: state
                                          .announcement[actualIndex]
                                          .announcementImg,
                                      time: state.announcement[actualIndex]
                                          .formattedTime),
                                );
                              },
                            ),
                          ),
                          SmoothPageIndicator(
                            controller: pageController,
                            count: state.announcement.length > 5
                                ? 5
                                : state.announcement.length,
                            effect: const WormEffect(
                              activeDotColor: Color(0xFF3B3B3B),
                              dotColor: Color(0xCCD9D9D9),
                              dotHeight: 7,
                              dotWidth: 7,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else if (state is AnnouncementFailedState) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: 163,
                      child: Center(
                        child: Text(
                          'Failed to load, please try again later',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        ),
                      ),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: 163,
                      child: Center(
                        child: Text(
                          'Network Error!',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Requested Duties',
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<RequestedDutiesBloc>(),
                              child: const StudentSeeAllPage(),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'See all',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color(0xCC6BB577),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 174,
                child: BlocBuilder<RequestedDutiesBloc, RequestedDutiesState>(
                  buildWhen: (previous, current) =>
                      (current is RequestedDutiesFetchLoadingState &&
                          previous is RequestedDutiesInitial) ||
                      current is RequestedDutiesFetchSuccessState ||
                      current is RequestedDutiesFetchFailedState,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case RequestedDutiesFetchLoadingState:
                        return Center(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 8, right: 16, top: 8),
                            child: ListView.builder(
                              itemCount: 15,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return const MyPostedDutiesHomePageLoading();
                              },
                            ),
                          ),
                        );
                      case RequestedDutiesFetchSuccessState:
                        state as RequestedDutiesFetchSuccessState;
                        if (state.requestedDuties.isEmpty) {
                          return SizedBox(
                            height: 174,
                            child: Center(
                              child: Text(
                                'Find duties',
                                style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B)),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            padding: const EdgeInsets.only(left: 8, right: 16),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.requestedDuties.length,
                              itemBuilder: (context, index) {
                                final request = state.requestedDuties[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: context
                                              .read<RequestedDutiesBloc>(),
                                          child: RequestedForDutiesInfoPage(
                                            title: 'requested',
                                            requestedDuties: request,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: PostedDutiesHome(
                                      id: request.id,
                                      profile: request.employeeProfile ?? '',
                                      date: request.date,
                                      building: request.employeeName,
                                      message: request.message,
                                      requestStatus: request.requestStatus,
                                      dutyStatus: request.dutyStatus,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      case RequestedDutiesFetchFailedState:
                        state as RequestedDutiesFetchFailedState;
                        log('the error in student home page is: ${state.errorMessage}');
                        return Text(state.errorMessage);
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            SliverLayoutBuilder(
              builder: (context, constraints) {
                final scrolled = constraints.scrollOffset > 0;
                return SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: AnimatedContainer(
                    duration: const Duration(milliseconds: 309),
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: scrolled
                            ? [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0.0, 10.0),
                                    blurRadius: 10.0,
                                    spreadRadius: -6.0)
                              ]
                            : []),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: GoogleFonts.nunito(
                          fontSize: scrolled ? 20 : 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                        child: const Text(
                          'Recent Activities',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            BlocConsumer<RecentActivitiesBloc, RecentActivitiesState>(
              listener: (context, state) {
                if (state is RecentActivitiesFailedState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                  log('The error in recent activity is: ${state.error}');
                }
              },
              builder: (context, state) {
                if (state is RecentActivitiesLoadingState) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return const MyRecentActivityLoadingIndicator();
                      },
                      childCount: 15,
                    ),
                  );
                } else if (state is RecentActivitiesSuccessState) {
                  if (state.recentActivities.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          'Your activity log is empty!',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3B3B3B),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return LiveSliverList(
                      controller: scrollController,
                      showItemDuration: const Duration(milliseconds: 300),
                      itemCount: state.recentActivities.length,
                      itemBuilder: (context, index, animation) {
                        final recentActivity = state.recentActivities[index];
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
                                // recentActivity.duty != null
                                //     ? Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) =>
                                //               PostedDutyInfoPage(
                                //                   profDuty:
                                //                       recentActivity.duty!),
                                //         ),
                                //       )
                                //     : null;
                              },
                              child: RecentActivityCard(
                                  title: recentActivity.title,
                                  description: recentActivity.description,
                                  message: recentActivity.message,
                                  date: recentActivity.date),
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else if (state is RecentActivitiesFailedState) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        'Network error',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Container(),
                  );
                }
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 77),
            )
          ],
        ),
      ),
    );
  }
}
