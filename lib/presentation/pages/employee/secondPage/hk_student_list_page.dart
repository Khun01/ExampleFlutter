import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/students/show/show_hk_students_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:help_isko/presentation/cards/shared/students_card.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/studentProfilePage/student_info_page.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_posted_duties_see_all_loading_indicator.dart';
import 'package:help_isko/repositories/api_repositories.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:ionicons/ionicons.dart';

class HkStudentListPage extends StatefulWidget {
  const HkStudentListPage({super.key});

  @override
  State<HkStudentListPage> createState() => _HkStudentListPageState();
}

class _HkStudentListPageState extends State<HkStudentListPage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final ShowHkStudentsBloc showHkStudentsBloc =
        ShowHkStudentsBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl))
          ..add(FetchHkStudentsEvent());
    return BlocConsumer<ShowHkStudentsBloc, ShowHkStudentsState>(
      bloc: showHkStudentsBloc,
      listener: (context, state) {
        if (state is ShowHkStudentsFailedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        Widget body;
        if (state is ShowHkStudentsLoadingState) {
          body = SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return const MyPostedDutiesSeeAllLoadingIndicator();
              },
              childCount: 15,
            ),
          );
        } else if (state is ShowHkStudentsSuccessState) {
          if (state.students.isEmpty) {
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
            final reversedList = state.students.reversed.toList();
            body = LiveSliverList(
              controller: scrollController,
              showItemDuration: const Duration(milliseconds: 300),
              itemCount: reversedList.length,
              itemBuilder: (context, index, animation) {
                final students = reversedList[index];
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
                              builder: (_) => BlocProvider.value(
                                value: context.read<MessageBloc>(),
                                child: StudentInfoPage(students: students),
                              ),
                            ),
                          );
                        },
                        child: StudentsCard(
                          name: students.name!,
                          course: students.course!,
                          profile: students.profile!,
                          studentNumber: students.studentNumber!,
                          targetUserId: students.studentId,
                          activeDutyCount: students.activeDutyCount!,
                          completedDutyCount: students.completedDutyCount!,
                        ),
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
                                    'HK Students',
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
