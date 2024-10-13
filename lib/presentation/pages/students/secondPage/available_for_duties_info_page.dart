import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/models/student/available_duty.dart';
import 'package:help_isko/presentation/bloc/student/dutiespage/duties_bloc.dart';
import 'package:help_isko/presentation/pages/wrapper.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_circular_progress_indicator.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:ionicons/ionicons.dart';

class AvailableForDutiesInfoPage extends StatelessWidget {
  final AvailableDuty availableDuty;
  const AvailableForDutiesInfoPage({super.key, required this.availableDuty});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DutiesBloc, DutiesState>(
      listener: (context, state) {
        if (state is DutiesAcceptSuccess) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Wrapper(role: 'Student'),
            ),
          );
        } else if (state is DutiesAcceptLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const MyCircularProgressIndicator(),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
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
                            child: const Icon(Ionicons.chevron_back_outline),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'Available Duty Details',
                            style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B)),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFA3D9A5),
                            borderRadius: BorderRadius.circular(500),
                          ),
                          child: availableDuty.employeeProfile != ''
                              ? ClipOval(
                                  child: Image.network(
                                    '$profileUrl${availableDuty.employeeProfile}',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      margin: const EdgeInsets.all(24),
                                      child: Image.asset(
                                        'assets/images/profile_clicked.png',
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.all(24),
                                  child: Image.asset(
                                    'assets/images/profile_clicked.png',
                                  ),
                                ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          availableDuty.employeeName,
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        ),
                        Text(
                          availableDuty.employeeNumber ?? 'N/A',
                          style: GoogleFonts.nunito(
                              fontSize: 12, color: const Color(0xCC3B3B3B)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Building:',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B)),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      availableDuty.building,
                      maxLines: 1,
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                  ),
                  const Divider(color: Color(0xFF3B3B3B)),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date:',
                              style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)),
                            ),
                            const SizedBox(height: 8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                availableDuty.date,
                                maxLines: 1,
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: const Color(0xFF3B3B3B),
                                ),
                              ),
                            ),
                            const Divider(color: Color(0xFF3B3B3B))
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time:',
                              style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)),
                            ),
                            const SizedBox(height: 8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                '${availableDuty.startTime} - ${availableDuty.endTime}',
                                maxLines: 1,
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: const Color(0xFF3B3B3B),
                                ),
                              ),
                            ),
                            const Divider(color: Color(0xFF3B3B3B))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Duty Status:',
                              style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              availableDuty.dutyStatus == 'pending'
                                  ? 'Pending'
                                  : availableDuty.dutyStatus == 'ongoing'
                                      ? 'On-going'
                                      : availableDuty.dutyStatus == 'completed'
                                          ? 'Completed'
                                          : 'Cancelled',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                color: const Color(0xFF3B3B3B),
                              ),
                            ),
                            const Divider(color: Color(0xFF3B3B3B))
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Students Needed:',
                              style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              availableDuty.maxScholars.toString(),
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                color: const Color(0xFF3B3B3B),
                              ),
                            ),
                            const Divider(color: Color(0xFF3B3B3B))
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECECEC),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          availableDuty.message,
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: const Color(0xFF3B3B3B),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<DutiesBloc>()
                          .add(DutiesAcceptEvent(id: availableDuty.id));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6BB577),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Accept',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFCFCFC)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
