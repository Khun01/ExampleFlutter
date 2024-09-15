import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/announcement/announcement_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/postedDuty/posted_duties_bloc.dart';
import 'package:help_isko/presentation/cards/announcement_card.dart';
import 'package:help_isko/presentation/cards/posted_duties_home.dart';
import 'package:help_isko/presentation/widgets/my_announcement_loading_indicator.dart';
import 'package:help_isko/presentation/widgets/my_app_bar.dart';
import 'package:help_isko/repositories/api_repositories.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProfHomePage extends StatelessWidget {
  const ProfHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                AnnouncementBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl))
                  ..add(FetchAnnouncement())),
        BlocProvider(
            create: (context) =>
                PostedDutiesBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl))
                  ..add(FetchDuty()))
      ],
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: MyAppBar(role: 'Employee'),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 24),
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
              BlocConsumer<AnnouncementBloc, AnnouncementState>(
                listener: (context, state) {
                  if (state is AnnouncementFailedState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                    log('The error is: ${state.error}');
                  }
                },
                builder: (context, state) {
                  if (state is AnnouncementLoadingState) {
                    return const SliverToBoxAdapter(
                      child: MyAnnouncementLoadingIndicator(),
                    );
                  } else if (state is AnnouncementSuccessState) {
                    if (state.announcement.isEmpty) {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 166,
                          child: Center(
                            child: Text(
                              'Coming soon!',
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
                          height: 166,
                          child: Column(
                            children: [
                              Expanded(
                                child: PageView.builder(
                                  controller: pageController,
                                  itemBuilder: (context, index) {
                                    final actualIndex =
                                        index % state.announcement.length;
                                    return AnnouncementCard(
                                        heading: state
                                            .announcement[actualIndex].heading,
                                        description: state
                                            .announcement[actualIndex]
                                            .description,
                                        announcementImg: state
                                            .announcement[actualIndex]
                                            .announcementImg,
                                        time: state
                                            .announcement[actualIndex].time);
                                  },
                                ),
                              ),
                              SmoothPageIndicator(
                                controller: pageController,
                                count: state.announcement.length > 5 ? 5 : state.announcement.length,
                                effect: const WormEffect(
                                  activeDotColor: Color(0xFF3B3B3B),
                                  dotColor: Color(0xCCD9D9D9),
                                  dotHeight: 7,
                                  dotWidth: 7,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  } else if (state is AnnouncementFailedState) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 166,
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
                        height: 166,
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
                  padding: const EdgeInsets.only(left: 20, top: 24, right: 20),
                  child: Row(
                    children: [
                      Text(
                        'Posted Duties',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'See all',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color(0xCC6BB577),
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
                builder: (context, state) {
                  if (state is PostedDutiesLoadingState) {
                    return const SliverToBoxAdapter(
                      child: SizedBox(
                          height: 166,
                          child: Center(
                            child: CircularProgressIndicator(),
                          )),
                    );
                  } else if (state is PostedDutiesSuccessState) {
                    if (state.duty.isEmpty) {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 166,
                          child: Center(
                            child: Text(
                              'Coming soon!',
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
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 166,
                          child: ListView.builder(
                            itemCount: state.duty.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final duty = state.duty[index];
                              return PostedDutiesHome(
                                  date: duty.date,
                                  building: duty.building,
                                  message: duty.message,
                                  dutyStatus: duty.dutyStatus);
                            },
                          ),
                        ),
                      );
                    }
                  } else if (state is PostedDutiestFailedState) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 166,
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
                        width: MediaQuery.of(context).size.width,
                        height: 166,
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
                        boxShadow: scrolled ? [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0.0, 10.0),
                              blurRadius: 10.0,
                              spreadRadius: -6.0)
                      ] : []),
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
              SliverToBoxAdapter(
                child: Container(
                  height: 1200,
                  decoration: const BoxDecoration(color: Colors.black),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 1200,
                  decoration: const BoxDecoration(color: Colors.blue),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 70),
              )
            ],
          ),
        ),
      ),
    );
  }
}
