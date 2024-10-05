import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/duty/add/add_duty_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/duty/show/posted_duties_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/requestForDuties/acceptStudent/accept_student_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/requestForDuties/declineStudent/decline_student_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/requestForDuties/showRequestForDuties/request_for_duties_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/announcement/announcement_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/recentActivity/recent_activities_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:help_isko/presentation/bloc/student/dutiespage/duties_bloc.dart';
import 'package:help_isko/presentation/bloc/student/homepage/requested_duties/requested_duties_bloc.dart';
import 'package:help_isko/presentation/pages/employee/firstPage/employee_duties_page.dart';
import 'package:help_isko/presentation/pages/employee/firstPage/employee_home_page.dart';
import 'package:help_isko/presentation/pages/employee/firstPage/employee_profile_page.dart';
import 'package:help_isko/presentation/pages/messenger_page.dart';
import 'package:help_isko/presentation/pages/students/firstPage/student_duties_page.dart';
import 'package:help_isko/presentation/pages/students/firstPage/student_profile_page.dart';
import 'package:help_isko/presentation/widgets/duty_dialog/add_delete_duty_success_dialog.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_circular_progress_indicator.dart';
import 'package:help_isko/presentation/widgets/add_duty/my_add_duty_bottom_dialog.dart';
import 'package:help_isko/presentation/pages/students/firstPage/student_home_page.dart';
import 'package:help_isko/repositories/api_repositories.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/repositories/messenger_repositories.dart';
import 'package:help_isko/repositories/student/dutiespage/available_duties_repository.dart';
import 'package:help_isko/repositories/student/homepage/requested_duties_repository.dart';
import 'package:help_isko/services/duty/duty_services.dart';
import 'package:help_isko/services/duty/request_for_duties_services.dart';
import 'package:help_isko/services/messenger_service.dart';
import 'package:help_isko/services/student/dutiespage/available_duties_service.dart';
import 'package:help_isko/services/student/homepage/requested_duties_service.dart';
import 'package:ionicons/ionicons.dart';

class Wrapper extends StatefulWidget {
  final String role;

  const Wrapper({
    super.key,
    required this.role,
  });

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AcceptStudentBloc acceptStudentBloc = AcceptStudentBloc(
        requestForDutyRepository: RequestForDutiesServices(baseUrl: baseUrl));
    final DeclineStudentBloc declineStudentBloc = DeclineStudentBloc(
        requestForDutyRepository: RequestForDutiesServices(baseUrl: baseUrl));
    final AnnouncementBloc announcementBloc =
        AnnouncementBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl))
          ..add(FetchAnnouncement(role: widget.role));
    final AddDutyBloc addDutyBloc =
        AddDutyBloc(dutyServices: DutyServices(baseUrl: baseUrl));
    final PostedDutiesBloc postedDutiesBloc =
        PostedDutiesBloc(dutyRepository: DutyServices(baseUrl: baseUrl))
          ..add(FetchDuty());
    final messengerBloc = MessageBloc(
        messengerRepository:
            MessengerRepository(MessengerService(role: widget.role)))
      ..add(MessageFetchEvent(role: widget.role));
    final RecentActivitiesBloc recentActivitiesBloc =
        RecentActivitiesBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl))
          ..add(FetchRecentActivitiesEvent(role: widget.role));
    final RequestForDutiesBloc requestForDutiesBloc = RequestForDutiesBloc(
        requestForDutyRepository: RequestForDutiesServices(baseUrl: baseUrl))
      ..add(FetchRequestForDutiesEvent());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => postedDutiesBloc,
        ),
        BlocProvider(create: (context) => acceptStudentBloc),
        BlocProvider(create: (context) => addDutyBloc),
        BlocProvider(create: (context) => declineStudentBloc),
        BlocProvider(create: (context) => messengerBloc),
        BlocProvider(create: (context) => recentActivitiesBloc),
        BlocProvider(create: (context) => requestForDutiesBloc)
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AddDutyBloc, AddDutyState>(
              bloc: addDutyBloc,
              listener: (context, state) {
                if (state is AddDutySuccessState) {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        const AddDeleteDutySuccessDialog(blocUse: 'AddDuty'),
                  );
                } else if (state is AddDutyFailedState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              }),
          BlocListener<AcceptStudentBloc, AcceptStudentState>(
              bloc: acceptStudentBloc,
              listener: (context, state) {
                if (state is AcceptStudentFailedState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                } else if (state is AcceptStudentSuccessSate) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Woww!!! Grape!!!')));
                }
              }),
          BlocListener<DeclineStudentBloc, DeclineStudentState>(
              bloc: declineStudentBloc,
              listener: (context, state) {
                if (state is DeclineStudentFailedState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                } else if (state is DeclineStudentSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Woww!!! Grape!!!')));
                }
              }),
        ],
        child: BlocBuilder<DeclineStudentBloc, DeclineStudentState>(
          bloc: declineStudentBloc,
          builder: (context, state) {
            return BlocBuilder<AddDutyBloc, AddDutyState>(
              bloc: addDutyBloc,
              builder: (context, addDutyState) {
                return BlocBuilder<AcceptStudentBloc, AcceptStudentState>(
                  bloc: acceptStudentBloc,
                  builder: (context, acceptStudentState) {
                    return Scaffold(
                      resizeToAvoidBottomInset: false,
                      body: SafeArea(
                        child: Stack(
                          children: [
                            IndexedStack(
                              index: selectedIndex,
                              children: widget.role == 'Employee'
                                  ? [
                                      MultiBlocProvider(
                                        providers: [
                                          BlocProvider.value(
                                              value: postedDutiesBloc),
                                          BlocProvider.value(
                                              value: announcementBloc),
                                          BlocProvider.value(
                                              value: recentActivitiesBloc)
                                        ],
                                        child: const EmployeeHomePage(),
                                      ),
                                      MultiBlocProvider(
                                        providers: [
                                          BlocProvider.value(
                                              value: acceptStudentBloc),
                                          BlocProvider.value(
                                              value: declineStudentBloc),
                                          BlocProvider.value(
                                              value: requestForDutiesBloc),
                                        ],
                                        child: const EmployeeDutiesPage(),
                                      ),
                                      const MessengerPage(role: 'Employee'),
                                      const EmployeeProfilePage(),
                                    ]
                                  : [
                                      MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                              create: (context) => RequestedDutiesBloc(
                                                  requestedDutiesRepository:
                                                      RequestedDutiesRepository(
                                                          requestedDutiesService:
                                                              RequestedDutiesService()))
                                                ..add(RequestedDutiesFetch())),
                                          BlocProvider.value(
                                              value: announcementBloc)
                                        ],
                                        child: const StudentHomePage(),
                                      ),
                                      MultiBlocProvider(providers: [
                                        BlocProvider(
                                          create: (context) => DutiesBloc(
                                              AvailableDutiesRepository(
                                                  AvailableDutiesService()))
                                            ..add(DutiesAvailableFetch()),
                                        ),
                                      ], child: const StudentDutiesPage()),
                                      const MessengerPage(role: 'Student'),
                                      const StudentProfilePage(),
                                    ],
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: Platform.isAndroid ? 0 : -10,
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: const Offset(0, -6),
                                  ),
                                ]),
                                child: FadeInUp(
                                  duration: const Duration(milliseconds: 700),
                                  child: BottomNavigationBar(
                                    selectedItemColor: const Color(0xFF6BB577),
                                    unselectedItemColor:
                                        const Color(0xFF3B3B3B),
                                    selectedLabelStyle: GoogleFonts.nunito(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    items: [
                                      BottomNavigationBarItem(
                                        label: 'Home',
                                        icon: selectedIndex == 0
                                            ? const ImageIcon(
                                                AssetImage(
                                                    'assets/images/home_clicked.png'),
                                                color: Color(0xFF6BB577))
                                            : const ImageIcon(AssetImage(
                                                'assets/images/home.png')),
                                      ),
                                      BottomNavigationBarItem(
                                        label: widget.role == 'Employee'
                                            ? 'Request'
                                            : 'Duties',
                                        icon: selectedIndex == 1
                                            ? const ImageIcon(
                                                AssetImage(
                                                    'assets/images/duties_clicked.png'),
                                                color: Color(0xFF6BB577))
                                            : const ImageIcon(AssetImage(
                                                'assets/images/duties.png')),
                                      ),
                                      BottomNavigationBarItem(
                                        label: 'Message',
                                        icon: selectedIndex == 2
                                            ? const Icon(
                                                Ionicons.chatbubble_ellipses,
                                                color: Color(0xFF6BB577))
                                            : const Icon(Ionicons
                                                .chatbubble_ellipses_outline),
                                      ),
                                      BottomNavigationBarItem(
                                        label: 'Profile',
                                        icon: selectedIndex == 3
                                            ? const ImageIcon(AssetImage(
                                                'assets/images/circle-user-clicked.png'))
                                            : const ImageIcon(AssetImage(
                                                'assets/images/circle-user.png')),
                                      ),
                                    ],
                                    currentIndex: selectedIndex,
                                    onTap: (int index) {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            if (widget.role == 'Employee' && selectedIndex == 0)
                              Positioned(
                                bottom: 86,
                                right: 16,
                                child: FadeInRight(
                                  duration: const Duration(milliseconds: 700),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color(0xFF6BB577),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(20)),
                                          ),
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.81,
                                              child: MultiBlocProvider(
                                                providers: [
                                                  BlocProvider.value(
                                                      value: addDutyBloc),
                                                  BlocProvider.value(
                                                      value: postedDutiesBloc),
                                                  BlocProvider.value(
                                                      value:
                                                          recentActivitiesBloc)
                                                ],
                                                child:
                                                    const MyAddDutyBottomDialog(),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.add_rounded,
                                        size: 40,
                                        color: Color(0xFFFCFCFC),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (addDutyState is AddDutyLoadingState ||
                                acceptStudentState
                                    is AcceptStudentLoadingState ||
                                state is DeclineStudentLoadingState) ...[
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              const Center(
                                child: MyCircularProgressIndicator(),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
