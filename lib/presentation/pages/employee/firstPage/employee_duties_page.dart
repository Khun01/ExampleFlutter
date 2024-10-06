import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/requestForDuties/showRequestForDuties/request_for_duties_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:help_isko/presentation/cards/duty_card/request_for_duties_card.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/studentProfilePage/student_info_page.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/request_for_duties_loading_indicator.dart';
import 'package:help_isko/presentation/widgets/my_app_bar.dart';

class EmployeeDutiesPage extends StatelessWidget {
  const EmployeeDutiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestForDutiesBloc, RequestForDutiesState>(
      listener: (context, state) {
        if (state is RequestForDutiesFailedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
          log('The error in request for duty is: ${state.error}');
        }
      },
      builder: (context, state) {
        Widget body;
        if (state is RequestForDutiesLoadingState) {
          body = SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return const RequestForDutiesLoadingIndicator();
                },
              ),
            ),
          );
        } else if (state is RequestForDutiesSuccessState) {
          if (state.requestForDuty.isEmpty) {
            body = SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  'No request available',
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B3B3B)),
                ),
              ),
            );
          } else {
            final reversedRequestForDuty =
                state.requestForDuty.reversed.toList();
            body = SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final requestForDuty = reversedRequestForDuty[index];
                return GestureDetector(
                  onTap: () {
                    log('The Request for duty card is clicked');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                  value: context.read<MessageBloc>(),
                                  child: StudentInfoPage(
                                      students: requestForDuty.studentData),
                                )));
                  },
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: context.read<RequestForDutiesBloc>(),
                      ),
                      BlocProvider.value(
                        value: context.read<MessageBloc>(),
                      ),
                    ],
                    child: RequestForDutiesCard(
                      dutyId: requestForDuty.dutyId,
                      profile: requestForDuty.studentData.profile!,
                      name: requestForDuty.studentData.name!,
                      building: requestForDuty.building,
                      startTime: requestForDuty.formattedStartTime,
                      endTime: requestForDuty.formattedEndTime,
                      date: requestForDuty.date,
                      message: requestForDuty.message,
                      studentId: requestForDuty.studentData.studentId,
                      studentNumber: requestForDuty.studentData.studentNumber,
                    ),
                  ),
                );
              }, childCount: state.requestForDuty.length),
            );
          }
        } else if (state is RequestForDutiesFailedState) {
          body = SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                'Failed to load, please try again later',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B)),
              ),
            ),
          );
        } else {
          body = SliverToBoxAdapter(
            child: Container(),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: MyAppBar(role: 'Employee'),
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
                              'Request for duties',
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                body,
                const SliverToBoxAdapter(
                  child: SizedBox(height: 86),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
