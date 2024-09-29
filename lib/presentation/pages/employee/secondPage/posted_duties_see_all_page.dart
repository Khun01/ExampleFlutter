import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/duty/show/posted_duties_bloc.dart';
import 'package:help_isko/presentation/cards/duty_card/posted_duties_see_all_card.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/duty_info_page.dart/posted_duty_info_page.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_posted_duties_see_all_loading_indicator.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/services/duty/duty_services.dart';
import 'package:ionicons/ionicons.dart';

class PostedDutiesSeeAllPage extends StatefulWidget {
  const PostedDutiesSeeAllPage({super.key});

  @override
  State<PostedDutiesSeeAllPage> createState() => _PostedDutiesSeeAllPageState();
}

class _PostedDutiesSeeAllPageState extends State<PostedDutiesSeeAllPage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final PostedDutiesBloc postedDutiesBloc =
        PostedDutiesBloc(dutyRepository: DutyServices(baseUrl: baseUrl))
          ..add(FetchDuty());
    return BlocConsumer<PostedDutiesBloc, PostedDutiesState>(
      bloc: postedDutiesBloc,
      listener: (context, state) {
        if (state is PostedDutiesSuccessState) {}
      },
      builder: (context, state) {
        Widget body;
        if (state is PostedDutiesLoadingState) {
          body = SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return const MyPostedDutiesSeeAllLoadingIndicator();
              },
              childCount: 15,
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
            body = LiveSliverList(
              controller: scrollController,
              showItemDuration: const Duration(milliseconds: 300),
              itemCount: reversedList.length,
              itemBuilder: (context, index, animation) {
                final duty = reversedList[index];
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
                                  builder: (context) =>
                                      PostedDutyInfoPage(profDuty: duty)));
                        },
                        child: PostedDutiesSeeAllCard(
                            date: duty.date!,
                            building: duty.building!,
                            message: duty.message!,
                            dutyStatus: duty.dutyStatus!,
                            startTime: duty.formattedStartTime,
                            endTime: duty.formattedEndTime),
                      )),
                );
              },
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
              controller: scrollController,
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
                const SliverToBoxAdapter(
                  child: SizedBox(height: 12),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
