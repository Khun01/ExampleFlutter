import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/presentation/bloc/student/dutiespage/duties_bloc.dart';
import 'package:help_isko/presentation/cards/duty_card/posted_duties_see_all_card.dart';
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
                }
                if (state is DutiesAcceptFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        'You have already requested this duty or it has been processed.'),
                    duration: Duration(seconds: 2),
                  ));
                }
                if (state is DutiesFetchFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage),
                    duration: Duration(seconds: 2),
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
                    log('loli3');
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final duties = state.availableDuties[index];
                          // return PostedDutiesSeeAllCard(
                          //     profile: duties.,
                          //     date: date,
                          //     building: building,
                          //     message: message,
                          //     dutyStatus: dutyStatus,
                          //     startTime: startTime,
                          //     endTime: endTime);
                        },
                        childCount: state.availableDuties.length,
                      ),
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
