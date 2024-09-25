import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/duty/add/add_duty_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/duty/fetch/posted_duties_bloc.dart';
import 'package:help_isko/presentation/widgets/my_add_duty_label.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_circular_progress_indicator.dart';

class MyAddDutyBottomDialog extends StatefulWidget {
  const MyAddDutyBottomDialog({super.key});

  @override
  State<MyAddDutyBottomDialog> createState() => _MyAddDutyBottomDialogState();
}

class _MyAddDutyBottomDialogState extends State<MyAddDutyBottomDialog> {
  final TextEditingController building = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController startAt = TextEditingController();
  final TextEditingController endAt = TextEditingController();
  final TextEditingController students = TextEditingController();
  final TextEditingController message = TextEditingController();

  @override
  void dispose() {
    building.dispose();
    date.dispose();
    startAt.dispose();
    endAt.dispose();
    students.dispose();
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddDutyBloc, AddDutyState>(
      listener: (context, state) {
        if (state is AddDutyFailedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state is AddDutySuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Added Successfully')));
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Duty Details',
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6BB577)),
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MyAddDutiesLabel(
                                icon: Icons.apartment_rounded,
                                label: 'Building'),
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                controller: building,
                                decoration: InputDecoration(
                                    hintText: 'PTC - 305',
                                    hintStyle: GoogleFonts.nunito(
                                        fontSize: 12,
                                        color: const Color(0x803B3B3B)),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 8)),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MyAddDutiesLabel(
                                icon: Icons.calendar_month_rounded,
                                label: 'Date'),
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                controller: date,
                                decoration: InputDecoration(
                                    hintText: 'YYYY-MM-DD',
                                    hintStyle: GoogleFonts.nunito(
                                        fontSize: 12,
                                        color: const Color(0x803B3B3B)),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 8)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MyAddDutiesLabel(
                                icon: Icons.alarm_rounded, label: 'Start at'),
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                controller: startAt,
                                decoration: InputDecoration(
                                    hintText: 'e.g., 09:00',
                                    hintStyle: GoogleFonts.nunito(
                                        fontSize: 12,
                                        color: const Color(0x803B3B3B)),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 8)),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MyAddDutiesLabel(
                                icon: Icons.alarm_rounded, label: 'End at'),
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                controller: endAt,
                                decoration: InputDecoration(
                                    hintText: 'e.g., 13:00',
                                    hintStyle: GoogleFonts.nunito(
                                        fontSize: 12,
                                        color: const Color(0x803B3B3B)),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 8)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const MyAddDutiesLabel(
                        icon: Icons.person, label: 'Students'),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        controller: students,
                        decoration: InputDecoration(
                            hintText: 'No. of Students',
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 12, color: const Color(0x803B3B3B)),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        controller: message,
                        decoration: InputDecoration(
                            hintText: 'Description',
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 14, color: const Color(0x803B3B3B)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            border: InputBorder.none),
                        maxLines: null,
                        expands: true,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const Spacer(),
                    MyButton(
                        onTap: () {
                          context.read<AddDutyBloc>().add(
                              AddDutySubmitButtonClicked(
                                  building.text,
                                  date.text,
                                  startAt.text,
                                  endAt.text,
                                  students.text,
                                  message.text,
                                  profDuty: const [],
                                  postedDutiesBloc:
                                      context.read<PostedDutiesBloc>()));
                        },
                        buttonText: 'Submit')
                  ],
                ),
              ),
              if (state is AddDutyLoadingState) ...[
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
              ]
            ],
          ),
        );
      },
    );
  }
}
