import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/student/dutiespage/duties_bloc.dart';
import 'package:help_isko/presentation/bloc/student/homepage/requested_duties/requested_duties_bloc.dart';
import 'package:help_isko/presentation/cards/duty_card/student/request_duty_student_card.dart';
import 'package:help_isko/presentation/pages/students/secondPage/available_for_duties_info_page.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_posted_duties_see_all_loading_indicator.dart';
import 'package:help_isko/presentation/widgets/my_app_bar.dart';

class StudentDutiesPage extends StatelessWidget {
  const StudentDutiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: MyAppBar(role: 'Student'),
            ),
            SliverLayoutBuilder(
              builder: (context, constraints) {
                final scrolled = constraints.scrollOffset > 0;
                return SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: AnimatedContainer(
                    duration: const Duration(milliseconds: 309),
                    padding:
                        EdgeInsets.only(left: 20, bottom: scrolled ? 0 : 8),
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
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      alignment: scrolled
                          ? Alignment.centerLeft
                          : Alignment.bottomLeft,
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: GoogleFonts.nunito(
                          fontSize: scrolled ? 20 : 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                        child: const Text(
                          'Available duties',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            BlocConsumer<DutiesBloc, DutiesState>(
              listenWhen: (previous, current) =>
                  current is DutiesAcceptLoading ||
                  current is DutiesAcceptSuccess ||
                  current is DutiesAcceptFailed ||
                  current is DutiesFetchFailed,
              listener: (context, state) {
                if (state is DutiesAcceptSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Successfully Requested'),
                    duration: Duration(seconds: 2),
                  ));
                  context.read<DutiesBloc>().add(DutiesAvailableFetch());
                }
                if (state is DutiesAcceptFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        'You have already requested this duty or it has been processed.'),
                    duration: Duration(seconds: 2),
                  ));
                }
                if (state is DutiesFetchFailed) {
                  log('The error in fetching data from duties fetched in student is: ${state.errorMessage}');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage),
                    duration: const Duration(seconds: 2),
                  ));
                }
              },
              buildWhen: (previous, current) =>
                  (current is DutiesFetchLoading &&
                      previous is DutiesInitial) ||
                  current is DutiesFetchSuccess,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case DutiesFetchLoading:
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return const MyPostedDutiesSeeAllLoadingIndicator();
                        },
                        childCount: 15,
                      ),
                    );
                  case DutiesFetchSuccess:
                    state as DutiesFetchSuccess;
                    if (state.availableDuties.isEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'There is no posted duties yet!',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final duties = state.availableDuties[index];
                            return MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: context.read<DutiesBloc>(),
                                ),
                                BlocProvider.value(
                                  value: context.read<RequestedDutiesBloc>(),
                                ),
                              ],
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AvailableForDutiesInfoPage(
                                        availableDuty: duties,
                                      ),
                                    ),
                                  );
                                },
                                child: RequestDutyStudentCard(
                                  role: 'Student',
                                  id: duties.id,
                                  profile: duties.employeeProfile ?? '',
                                  date: duties.date,
                                  building: duties.employeeName,
                                  message: duties.message,
                                  startTime: duties.startTime,
                                  endTime: duties.endTime,
                                ),
                              ),
                            );
                          },
                          childCount: state.availableDuties.length,
                        ),
                      );
                    }
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
