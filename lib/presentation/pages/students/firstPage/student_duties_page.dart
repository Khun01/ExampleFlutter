import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/student/dutiespage/duties_bloc.dart';
import 'package:help_isko/presentation/bloc/student/homepage/requested_duties/requested_duties_bloc.dart';
import 'package:help_isko/presentation/cards/duty_card/student/request_duty_student_card.dart';
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
                  log('The error in fetching data is: ${state.errorMessage}');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage),
                    duration: const Duration(seconds: 2),
                  ));
                }
              },
              buildWhen: (previous, current) =>
                  current is DutiesFetchLoading ||
                  current is DutiesFetchSuccess,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case DutiesFetchLoading:
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator(),
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
                              child: RequestDutyStudentCard(
                                role: 'Student',
                                id: duties.id,
                                profile: duties.employeeProfile!,
                                date: duties.date,
                                building: duties.employeeName,
                                message: duties.message,
                                startTime: duties.startTime,
                                endTime: duties.endTime,
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
