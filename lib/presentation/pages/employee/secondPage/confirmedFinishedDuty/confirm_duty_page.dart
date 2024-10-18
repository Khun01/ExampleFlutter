import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/completedDuty/completed_duty_bloc.dart';
import 'package:help_isko/presentation/cards/confirm_duty_card.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/services/employee/duty/duty_services.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:table_calendar/table_calendar.dart';

class ConfirmDutyPage extends StatefulWidget {
  const ConfirmDutyPage({super.key});

  @override
  State<ConfirmDutyPage> createState() => _ConfirmDutyState();
}

class _ConfirmDutyState extends State<ConfirmDutyPage> {
  final scrollController = ScrollController();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  int currentStep = 0;

  final Map<DateTime, List<String>> _events = {
    DateTime.now(): ['Event 1', 'Event 2'],
    DateTime.utc(2024, 10, 17): ['Event 1', 'Event 2', 'Event 3'],
  };

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM d, y').format(now);

    final CompletedDutyBloc completedDutyBloc =
        CompletedDutyBloc(dutyRepository: DutyServices(baseUrl: baseUrl))
          ..add(DutyCompletedFetch());

    return BlocProvider(
      create: (context) => completedDutyBloc,
      child: BlocConsumer<CompletedDutyBloc, CompletedDutyState>(
        listener: (context, state) {
          if (state is CompletedDutyFailedState) {
            log('The error in fetching cmpleted duty is: ${state.error}');
          } else if (state is CompletedDutySuccessState) {
            log('The fetching of cmpleted duty is success');
          }
        },
        builder: (context, state) {
          Widget body;
          if (state is CompletedDutyFailedState) {
            body = SliverToBoxAdapter(child: Text(state.error.toString()));
          } else if (state is CompletedDutySuccessState) {
            body = const SliverToBoxAdapter(
              child: Text('Succcess'),
            );
          } else if (state is CompletedDutyLoadingState) {
            body = const SliverToBoxAdapter(
              child: CircularProgressIndicator(),
            );
          } else {
            body = const SliverToBoxAdapter(child: SizedBox.shrink());
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
                                      spreadRadius: -6.0,
                                    )
                                  ]
                                : [],
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0x1AA3D9A5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
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
                                    'Confirm Duty',
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF3B3B3B),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16, left: 16),
                          child: Text(
                            formattedDate,
                            style: GoogleFonts.nunito(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0x803B3B3B),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'Today',
                            style: GoogleFonts.nunito(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B),
                            ),
                          ),
                        ),
                        TableCalendar(
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: _focusedDay,
                          selectedDayPredicate: (day) =>
                              isSameDay(_selectedDay, day),
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                                if (isSameDay(selectedDay, DateTime.now())) {
                                  _calendarFormat = CalendarFormat.month;
                                } else {
                                  _calendarFormat = CalendarFormat.week;
                                }
                              });
                            });
                          },
                          calendarFormat: _calendarFormat,
                          onFormatChanged: (format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          },
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleTextStyle: GoogleFonts.nunito(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: const Color(0x803B3B3B),
                            ),
                            titleTextFormatter: (date, locale) {
                              return DateFormat('MMMM', locale).format(date);
                            },
                            headerPadding: const EdgeInsets.only(
                                left: 16, bottom: 16, top: 16),
                            leftChevronVisible: false,
                            rightChevronVisible: false,
                          ),
                          calendarStyle: CalendarStyle(
                            defaultTextStyle: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: const Color(0xFF3B3B3B),
                            ),
                            weekendTextStyle: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            todayTextStyle: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFCFCFC),
                            ),
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0x803B3B3B),
                            ),
                            weekendStyle: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0x803B3B3B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  body,
                  _events[_selectedDay] == null ||
                          _events[_selectedDay]!.isEmpty
                      ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Text(
                              'No completed duty for today.',
                              style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: const Color(0x803B3B3B),
                              ),
                            ),
                          ),
                        )
                      : SliverList.builder(
                          itemCount: _events[_selectedDay]!.length,
                          itemBuilder: (context, index) {
                            return const ConfirmDutyCard();
                          },
                        ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
