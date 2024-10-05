import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/presentation/bloc/auth/logout/logout_bloc.dart';
import 'package:help_isko/presentation/bloc/auth/logout/logout_event.dart';
import 'package:help_isko/presentation/bloc/auth/logout/logout_state.dart';
import 'package:help_isko/presentation/bloc/student/homepage/hk_status/hk_status_bloc.dart';
import 'package:help_isko/presentation/bloc/student/homepage/requested_duties/requested_duties_bloc.dart';
import 'package:help_isko/presentation/pages/students/secondPage/student_see_all_page.dart';
import 'package:help_isko/presentation/widgets/my_app_bar.dart';
import 'package:help_isko/repositories/api_repositories.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/presentation/pages/landing_page.dart';
import 'package:help_isko/repositories/student/homepage/hk_status_repository.dart';
import 'package:help_isko/services/student/homepage/hk_status_service.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LogoutBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl)),
        ),
        BlocProvider(
          create: (context) => HkStatusBloc(
              hkStatusRepository:
                  HkStatusRepository(hkStatusService: HkStatusService()))
            ..add(HkStatusFetchDataEvent()),
        ),
        // BlocProvider(
        //     create: (context) => RequestedDutiesBloc(
        //         requestedDutiesRepository: RequestedDutiesRepository(
        //             requestedDutiesService: RequestedDutiesService()))
        //       ..add(RequestedDutiesFetch())),
      ],
      child: Scaffold(
        body: BlocListener<LogoutBloc, LogoutState>(
          listener: (context, state) {
            if (state is LogoutFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is LogoutSuccess) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LandingPage()));
            }
          },
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                // SliverList(
                //   delegate: SliverChildListDelegate([
                //     const MyAppBar(
                //       selectedRole: 'Student',
                //     )
                //   ]),
                // ),
                const SliverToBoxAdapter(
                  child: MyAppBar(role: "Student"),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<HkStatusBloc, HkStatusState>(
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case HkStatusFetchLoading:
                          return CircularProgressIndicator();
                        case HkStatusFetchSuccess:
                          state as HkStatusFetchSuccess;
                          return Text('Duty Hours: ${state.percentage}');
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                    child: Text('Announcement'),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Requested Duties'),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                        value:
                                            context.read<RequestedDutiesBloc>(),
                                        child: StudentSeeAllPage())));
                          },
                          child: Text('See all'))
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    child:
                        BlocBuilder<RequestedDutiesBloc, RequestedDutiesState>(
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case RequestedDutiesFetchLoadingState:
                            return CircularProgressIndicator();
                          case RequestedDutiesFetchSuccessState:
                            state as RequestedDutiesFetchSuccessState;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.requestedDuties.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    width: 128,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Text(
                                            // //     "hi ${state.requestedDuties[index].employeeProfile != null}")
                                            state.requestedDuties[index]
                                                        .employeeProfile !=
                                                    ''
                                                ? Image.network(
                                                    state.requestedDuties[index]
                                                        .employeeProfile!,
                                                    height: 30,
                                                  )
                                                : Image.asset(
                                                    'assets/images/profile_clicked.png',
                                                    height: 30),

                                            const SizedBox(width: 6),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  //status button
                                                  GestureDetector(
                                                    onTap: () {
                                                      final status = requestDutyStatus(
                                                          state
                                                              .requestedDuties[
                                                                  index]
                                                              .requestStatus,
                                                          state
                                                              .requestedDuties[
                                                                  index]
                                                              .dutyStatus);

                                                      if (status == 'cancel') {
                                                        print('hello');
                                                        context
                                                            .read<
                                                                RequestedDutiesBloc>()
                                                            .add(RequestedDutyCancelEvent(
                                                                id: state
                                                                    .requestedDuties[
                                                                        index]
                                                                    .id));
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.amber,
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8),
                                                      child: Center(
                                                        child: Text(
                                                          requestDutyStatus(
                                                              state
                                                                  .requestedDuties[
                                                                      index]
                                                                  .requestStatus,
                                                              state
                                                                  .requestedDuties[
                                                                      index]
                                                                  .dutyStatus),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // date
                                                  Text(state
                                                      .requestedDuties[index]
                                                      .date)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        // employee name
                                        Text(state.requestedDuties[index]
                                            .employeeName),
                                        // message
                                        Text(state
                                            .requestedDuties[index].message),

                                        Text(
                                            '${state.requestedDuties[index].id}')
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          case RequestedDutiesFetchFailedState:
                            state as RequestedDutiesFetchFailedState;
                            return Text(state.errorMessage);
                          default:
                            return SizedBox();
                        }
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 160),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<LogoutBloc, LogoutState>(
                    builder: (context, state) {
                      return state is LogoutLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<LogoutBloc>(context).add(
                                        LogoutButtonPressed(role: 'Student'));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Colors.black)),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    child: const Text(
                                      'Logout',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )),
                            );
                    },
                  ),
                )
              ],
            ),
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
