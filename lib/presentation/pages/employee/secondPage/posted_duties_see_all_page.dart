import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/duty/fetchDuty/posted_duties_bloc.dart';
import 'package:help_isko/presentation/cards/posted_duties_see_all_card.dart';
import 'package:help_isko/repositories/api_repositories.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:ionicons/ionicons.dart';

class PostedDutiesSeeAllPage extends StatelessWidget {
  const PostedDutiesSeeAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PostedDutiesBloc postedDutiesBloc =
        PostedDutiesBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl))
          ..add(FetchDuty());
    return BlocConsumer<PostedDutiesBloc, PostedDutiesState>(
      bloc: postedDutiesBloc,
      listener: (context, state) {},
      builder: (context, state) {
        Widget body;
        if (state is PostedDutiesLoadingState) {
          body = const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is PostedDutiesSuccessState) {
          if (state.duty.isEmpty) {
            body = SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  'Coming soon!',
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B3B3B)),
                ),
              ),
            );
          } else {
            final reversedList = state.duty.reversed.toList();
            body = SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final duty = reversedList[index];
                return GestureDetector(
                  onTap: () {},
                  child: PostedDutiesSeeAllCard(
                    date: duty.date,
                    building: duty.building,
                    message: duty.message,
                    dutyStatus: duty.dutyStatus,
                    startTime: duty.formattedStartTime,
                    endTime: duty.formattedEndTime,
                  ),
                );
              }, childCount: reversedList.length),
            );
          }
        } else {
          body = SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                'Network Error',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B)),
              ),
            ),
          );
        }
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final scrolled = constraints.scrollOffset > 0;
                    return SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      collapsedHeight: 70,
                      flexibleSpace: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              boxShadow: scrolled
                                  ? [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: const Offset(0.0, 10.0),
                                          blurRadius: 10.0,
                                          spreadRadius: -6.0)
                                    ]
                                  : []),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: const Color(0x1AA3D9A5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                        Ionicons.chevron_back_outline),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Center(
                                  child: Text(
                                    'Posted Duties',
                                    style: GoogleFonts.nunito(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF3B3B3B)),
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
                body,
              ],
            ),
          ),
        );
      },
    );
  }
}
