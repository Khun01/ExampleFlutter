import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/student/homepage/hk_status/hk_status_bloc.dart';
import 'package:help_isko/repositories/student/homepage/hk_status_repository.dart';
import 'package:help_isko/services/student/homepage/hk_status_service.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyDutyHours extends StatefulWidget {
  const MyDutyHours({super.key});

  @override
  State<MyDutyHours> createState() => _MyDutyHoursState();
}

class _MyDutyHoursState extends State<MyDutyHours>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  var percentage = 0.0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation = Tween<double>(begin: 0, end: 0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.reset();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HkStatusBloc(
          hkStatusRepository:
              HkStatusRepository(hkStatusService: HkStatusService()))
        ..add(HkStatusFetchDataEvent()),
      child: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFFCFCFC),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0.0, 10.0),
              blurRadius: 10.0,
              spreadRadius: -6.0,
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/check-mark.png',
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 10),
            BlocConsumer<HkStatusBloc, HkStatusState>(
              listener: (context, state) {
                if (state is HkStatusFetchSuccess) {
                  percentage = state.percentage;
                  animation = Tween<double>(begin: 0, end: percentage)
                      .animate(controller);
                  controller.forward();
                }
              },
              builder: (context, state) {
                Widget body;
                if (state is HkStatusFetchSuccess) {
                  body = LinearPercentIndicator(
                    padding: EdgeInsets.zero,
                    lineHeight: 9,
                    percent: animation.value,
                    progressColor: const Color(0xFF4ECB71),
                    backgroundColor: const Color(0xFFD9D9D9),
                    barRadius: const Radius.circular(20),
                    center: Text(
                      '${(animation.value * 100).toStringAsFixed(2)}%',
                      style: GoogleFonts.nunito(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                  );
                } else if (state is HkStatusFetchLoading) {
                  body = const Center(
                    child: SizedBox(
                      height: 10,
                      width: 10,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  );
                } else if (state is HkStatusFetchFailed) {
                  body = Text(
                    'Failed to fetch data',
                    style: GoogleFonts.nunito(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF803B3B),
                    ),
                  );
                } else {
                  body = const SizedBox.shrink();
                }
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Duty Hours',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 3),
                      body,
                      const SizedBox(height: 3),
                      Text(
                        percentage == 1.0 ? 'Completed' : 'Progress',
                        style: GoogleFonts.nunito(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0x803B3B3B),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
