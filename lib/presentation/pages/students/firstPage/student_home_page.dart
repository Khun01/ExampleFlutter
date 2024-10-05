import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/requestForDuties/showRequestForDuties/request_for_duties_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/announcement/announcement_bloc.dart';
import 'package:help_isko/presentation/bloc/student/homepage/hk_status/hk_status_bloc.dart';
import 'package:help_isko/presentation/bloc/student/homepage/requested_duties/requested_duties_bloc.dart';
import 'package:help_isko/presentation/cards/announcement_card.dart';
import 'package:help_isko/presentation/cards/duty_card/posted_duties_home.dart';
import 'package:help_isko/presentation/pages/students/secondPage/student_see_all_page.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_announcement_loading_indicator.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_posted_duties_home_page_loading.dart';
import 'package:help_isko/presentation/widgets/my_announcemet_dialog.dart';
import 'package:help_isko/presentation/widgets/my_app_bar.dart';
import 'package:help_isko/presentation/widgets/studentDutyHours/my_duty_hours.dart';
import 'package:help_isko/repositories/student/homepage/hk_status_repository.dart';
import 'package:help_isko/services/student/homepage/hk_status_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HkStatusBloc(
              hkStatusRepository:
                  HkStatusRepository(hkStatusService: HkStatusService()))
            ..add(HkStatusFetchDataEvent()),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: MyAppBar(role: "Student"),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 8),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<HkStatusBloc, HkStatusState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case HkStatusFetchLoading:
                        return const Center(child: CircularProgressIndicator());
                      case HkStatusFetchSuccess:
                        state as HkStatusFetchSuccess;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MyDutyHours(percentage: state.percentage),
                        );
                      case HkStatusFetchFailed:
                        state as HkStatusFetchFailed;
                        return const Text('Failed to fetch hk status');
                      default:
                        return const SizedBox();
                    }
                  },
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
                                    child: FadeInRight(
                                      duration:
                                          const Duration(milliseconds: 700),
                                      child: AnnouncementCard(
                                          heading: state
                                              .announcement[actualIndex]
                                              .heading,
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
                                      value:
                                          context.read<RequestedDutiesBloc>(),
                                      child: const StudentSeeAllPage())));
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
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.requestedDuties.length,
                              itemBuilder: (context, index) {
                                final request = state.requestedDuties[index];
                                return Container(
                                  margin: const EdgeInsets.only(
                                      left: 8, right: 16, top: 8),
                                  child: BlocProvider(
                                    create: (_) =>
                                        context.read<RequestForDutiesBloc>(),
                                    child: PostedDutiesHome(
                                        id: request.id,
                                        profile: request.employeeProfile,
                                        date: request.date,
                                        building: request.employeeName,
                                        message: request.message,
                                        requestStatus: request.requestStatus,
                                        dutyStatus: request.dutyStatus),
                                  ),
                                );
                              },
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
            ],
          ),
        ),
      ),
    );
  }
}

String requestDutyStatus(String requestStatus, String dutyStatus) {
  if (requestStatus == 'undecided' && dutyStatus == 'pending') {
    return 'cancel';
  } else if (requestStatus == 'accepted' &&
      (dutyStatus == 'pending' || dutyStatus == 'active')) {
    return 'pending';
  } else if (requestStatus == 'accepted' && dutyStatus == 'ongoing') {
    return 'ongoing';
  } else {
    return '';
  }
}
