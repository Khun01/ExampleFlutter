import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/announcement/announcement_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/duty/show/posted_duties_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/recentActivity/recent_activities_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:help_isko/presentation/cards/shared/announcement_card.dart';
import 'package:help_isko/presentation/cards/duty_card/posted_duties_home.dart';
import 'package:help_isko/presentation/cards/shared/recent_activity_card.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/posted_duties_see_all_page.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/dutyInfoPage/posted_duty_info_page.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_announcement_loading_indicator.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_posted_duties_home_page_loading.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_recent_activity_loading_indicator.dart';
import 'package:help_isko/presentation/widgets/my_announcemet_dialog.dart';
import 'package:help_isko/presentation/widgets/my_app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EmployeeHomePage extends StatelessWidget {
  const EmployeeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final scrollController = ScrollController();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: MyAppBar(role: 'Employee'),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 24),
                child: FadeInLeft(
                  duration: const Duration(milliseconds: 700),
                  child: Text(
                    'Announcement',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B3B3B),
                    ),
                  ),
                ),
              ),
            ),
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
                                  child: FadeInRight(
                                    duration: const Duration(milliseconds: 700),
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
                                  ),
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
                padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                child: Row(
                  children: [
                    FadeInLeft(
                      duration: const Duration(milliseconds: 700),
                      child: Text(
                        'Posted Duties',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<MessageBloc>(),
                              child: const PostedDutiesSeeAllPage(),
                            ),
                          ),
                        );
                      },
                      child: FadeInRight(
                        duration: const Duration(milliseconds: 700),
                        child: Text(
                          'See all',
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: const Color(0xCC6BB577),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocConsumer<PostedDutiesBloc, PostedDutiesState>(
              listener: (context, state) {
                if (state is PostedDutiestFailedState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                  log('The error is: ${state.error}');
                }
              },
              buildWhen: (previous, current) =>
                  (current is PostedDutiesLoadingState &&
                      previous is PostedDutiesInitial) ||
                  current is PostedDutiesSuccessState,
              builder: (context, state) {
                if (state is PostedDutiesLoadingState) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 166,
                      margin: const EdgeInsets.only(left: 8, right: 16, top: 8),
                      child: ListView.builder(
                        itemCount: 15,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return const MyPostedDutiesHomePageLoading();
                        },
                      ),
                    ),
                  );
                } else if (state is PostedDutiesSuccessState) {
                  if (state.duty.isEmpty) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 174,
                        child: Center(
                          child: Text(
                            'You have not posted any duties yet.',
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B)),
                          ),
                        ),
                      ),
                    );
                  } else {
                    final reversedList = state.duty.reversed.toList();
                    return SliverToBoxAdapter(
                        child: Container(
                      height: 166,
                      margin: const EdgeInsets.only(left: 8, right: 16, top: 8),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: reversedList.length,
                        itemBuilder: (context, index) {
                          final duty = reversedList[index];
                          return FadeInRight(
                            duration: const Duration(seconds: 1),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: context.read<MessageBloc>(),
                                      child: PostedDutyInfoPage(profDuty: duty),
                                    ),
                                  ),
                                );
                              },
                              child: PostedDutiesHome(
                                date: duty.date!,
                                building: duty.building!,
                                message: duty.message!,
                                dutyStatus: duty.dutyStatus!,
                                profile: duty.profProfile,
                              ),
                            ),
                          );
                        },
                      ),
                    ));
                  }
                } else if (state is PostedDutiestFailedState) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: 174,
                      child: Center(
                        child: Text(
                          'Failed to load, please try again later',
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
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 174,
                      child: Center(
                        child: Text(
                          'Network Error!',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        ),
                      ),
                    ),
                  );
                }
              },
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
                        child: FadeInLeft(
                          duration: const Duration(milliseconds: 700),
                          child: const Text(
                            'Recent Activities',
                          ),
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
              buildWhen: (previous, current) =>
                  (current is RecentActivitiesLoadingState &&
                      previous is RecentActivitiesInitial) ||
                  current is RecentActivitiesSuccessState,
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
                            child: RecentActivityCard(
                                title: recentActivity.title,
                                description: recentActivity.description,
                                message: recentActivity.message,
                                date: recentActivity.date),
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
