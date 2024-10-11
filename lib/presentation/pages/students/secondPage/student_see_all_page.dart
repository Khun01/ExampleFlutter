import 'dart:developer';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/requestForDuties/showRequestForDuties/request_for_duties_bloc.dart';
import 'package:help_isko/presentation/bloc/student/homepage/requested_duties/requested_duties_bloc.dart';
import 'package:help_isko/presentation/cards/duty_card/student/requested_duties_student_see_all_card.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_circular_progress_indicator.dart';
import 'package:ionicons/ionicons.dart';

class StudentSeeAllPage extends StatelessWidget {
  const StudentSeeAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
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
                                child:
                                    const Icon(Ionicons.chevron_back_outline),
                              ),
                            ),
                          ),
                          Positioned(
                            child: Center(
                              child: Text(
                                'Requested Duties',
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
            BlocConsumer<RequestedDutiesBloc, RequestedDutiesState>(
              listener: (context, state) {
                if (state is RequestedDutiesCancelLoadingState) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) =>
                          const MyCircularProgressIndicator());
                } else if (state is RequestedDutiesCancelSuccessState) {
                  Navigator.pop(context);
                }
              },
              buildWhen: (previous, current) =>
                  (current is RequestedDutiesFetchLoadingState &&
                      previous is RequestedDutiesInitial) ||
                  current is RequestedDutiesFetchSuccessState,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case RequestedDutiesFetchLoadingState:
                    state as RequestedDutiesFetchLoadingState;
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case RequestedDutiesFetchSuccessState:
                    state as RequestedDutiesFetchSuccessState;
                    if (state.requestedDuties.isEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'You did not request for any duties yet.',
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B)),
                          ),
                        ),
                      );
                    } else {
                      return LiveSliverList(
                        controller: scrollController,
                        showItemDuration: const Duration(milliseconds: 300),
                        itemCount: state.requestedDuties.length,
                        itemBuilder: (context, index, animation) {
                          final duty = state.requestedDuties[index];
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
                              child: BlocProvider.value(
                                value: context.read<RequestedDutiesBloc>(),
                                child: RequestedDutiesStudentSeeAllCard(
                                  id: duty.id,
                                  profile: duty.employeeProfile ?? '',
                                  date: duty.date,
                                  employeeName: duty.employeeName,
                                  building: duty.building,
                                  message: duty.message,
                                  time: duty.time,
                                  dutyStatus: duty.dutyStatus,
                                  requestStatus: duty.requestStatus,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  case RequestForDutiesFailedState:
                    state as RequestedDutiesFetchFailedState;
                    log('The error in see all duties page for studnet is: ${state.errorMessage}');
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Text(state.errorMessage),
                    );
                  default:
                    return const SliverToBoxAdapter(child: SizedBox());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
