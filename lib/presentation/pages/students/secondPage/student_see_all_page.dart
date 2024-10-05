import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/requestForDuties/showRequestForDuties/request_for_duties_bloc.dart';
import 'package:help_isko/presentation/bloc/student/homepage/requested_duties/requested_duties_bloc.dart';
import 'package:help_isko/presentation/pages/students/firstPage/student_home_page.dart';

class StudentSeeAllPage extends StatelessWidget {
  const StudentSeeAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Requested Duties"),
        ),
        body: BlocConsumer<RequestedDutiesBloc, RequestedDutiesState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case RequestedDutiesFetchSuccessState:
                state as RequestedDutiesFetchSuccessState;
                return ListView.builder(
                    itemCount: state.requestedDuties.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.white,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                state.requestedDuties[index].employeeProfile !=
                                        ""
                                    ? Image.network(
                                        '${state.requestedDuties[index].employeeProfile}',
                                        height: 30,
                                      )
                                    : Image.asset(
                                        'assets/images/profile_clicked.png',
                                        height: 30,
                                      ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // name
                                    Text(state
                                        .requestedDuties[index].employeeName),
                                    // message
                                    Text(state.requestedDuties[index].message),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Date: ${state.requestedDuties[index].date}',
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                '${state.requestedDuties[index].building} : ',
                                                style: const TextStyle(
                                                    fontSize: 10)),
                                            Text(
                                                state.requestedDuties[index]
                                                    .time,
                                                style: const TextStyle(
                                                    fontSize: 10)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                                top: 2,
                                right: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    final status = requestDutyStatus(
                                        state.requestedDuties[index]
                                            .requestStatus,
                                        state
                                            .requestedDuties[index].dutyStatus);
                                    if (status == 'cancel') {
                                      context.read<RequestedDutiesBloc>().add(
                                          RequestedDutyCancelEvent(
                                              id: state
                                                  .requestedDuties[index].id));
                                    }
                                  },
                                  child: Container(
                                    width: 75,
                                    // padding: EdgeInsets.all(8),
                                    color: Colors.amber,
                                    child: Center(
                                      child: Text(requestDutyStatus(
                                          state.requestedDuties[index]
                                              .requestStatus,
                                          state.requestedDuties[index]
                                              .dutyStatus)),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      );
                    });
              case RequestForDutiesFailedState:
                state as RequestedDutiesFetchFailedState;
                log('The error in see all duties page for studnet is: ${state.errorMessage}');
                return Text(state.errorMessage);
              default:
                return SizedBox();
            }
          },
        ));
  }
}
