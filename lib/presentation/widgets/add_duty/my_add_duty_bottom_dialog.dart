import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/duty/add/add_duty_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/duty/show/posted_duties_bloc.dart';
import 'package:help_isko/presentation/bloc/shared/recentActivity/recent_activities_bloc.dart';
import 'package:help_isko/presentation/widgets/add_duty/my_add_duty_field.dart';
import 'package:help_isko/presentation/widgets/add_duty/my_add_duty_label.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';
import 'package:intl/intl.dart';

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

  final GlobalKey<FormState> _formKeyDate = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyStartAt = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyEndAt = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyBuilding = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyStudent = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyMessage = GlobalKey<FormState>();

  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;

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
    String formatTimeOfDay(TimeOfDay time) {
      final now = DateTime.now();
      final formattedTime =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);
      return "${formattedTime.hour.toString().padLeft(2, '0')}:${formattedTime.minute.toString().padLeft(2, '0')}";
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyAddDutiesLabel(
                            icon: Icons.apartment_rounded, label: 'Building'),
                        MyAddDutyField(
                            formKey: _formKeyBuilding,
                            controller: building,
                            hintText: 'PTC - 305',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter building';
                              }
                              return null;
                            })
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyAddDutiesLabel(
                            icon: Icons.calendar_month_rounded, label: 'Date'),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = pickedDate;
                                date.text =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                              });
                            }
                          },
                          child: AbsorbPointer(
                            child: MyAddDutyField(
                              formKey: _formKeyDate,
                              controller: date,
                              hintText: 'YYYY-MM-DD',
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                String pattern = r'^\d{4}-\d{2}-\d{2}$';
                                RegExp regExp = RegExp(pattern);
                                if (value == null || value.isEmpty) {
                                  return 'Please enter date';
                                } else if (!regExp.hasMatch(value)) {
                                  return 'Enter a valid date (YYYY-MM-DD)';
                                }
                                return null;
                              },
                              readOnly: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyAddDutiesLabel(
                            icon: Icons.alarm_rounded, label: 'Start at'),
                        MyAddDutyField(
                          formKey: _formKeyStartAt,
                          controller: startAt,
                          hintText: 'Start Time',
                          readOnly: true,
                          validator: (value) {
                            String pattern = r'^([01][0-9]|2[0-3]):[0-5][0-9]$';
                            RegExp regExp = RegExp(pattern);
                            if (value == null || value.isEmpty) {
                              return null;
                            } else if (!regExp.hasMatch(value)) {
                              return 'Enter a valid time in 24-hour format (HH:mm)';
                            }
                            return null;
                          },
                          onTap: () async {
                            TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (selectedTime != null) {
                              if (selectedDate != null &&
                                  selectedDate!
                                      .isAtSameMomentAs(DateTime.now())) {
                                final now = DateTime.now();
                                final currentTime = TimeOfDay(
                                    hour: now.hour, minute: now.minute);
                                if (selectedTime.hour < currentTime.hour ||
                                    (selectedTime.hour == currentTime.hour &&
                                        selectedTime.minute <
                                            currentTime.minute)) {
                                  log('Selected start time has already passed');
                                  return;
                                }
                              }
                              setState(() {
                                selectedStartTime = selectedTime;
                                startAt.text = formatTimeOfDay(selectedTime);
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyAddDutiesLabel(
                            icon: Icons.alarm_rounded, label: 'End at'),
                        MyAddDutyField(
                          formKey: _formKeyEndAt,
                          controller: endAt,
                          hintText: 'End Time',
                          readOnly: true,
                          validator: (value) {
                            String pattern = r'^([01][0-9]|2[0-3]):[0-5][0-9]$';
                            RegExp regExp = RegExp(pattern);
                            if (value == null || value.isEmpty) {
                              return 'Please enter a time';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Enter a valid time in 24-hour format (HH:mm)';
                            }
                            return null;
                          },
                          onTap: () async {
                            TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (selectedTime != null) {
                              if (selectedStartTime != null) {
                                final startDateTime = DateTime(
                                    selectedDate!.year,
                                    selectedDate!.month,
                                    selectedDate!.day,
                                    selectedStartTime!.hour,
                                    selectedStartTime!.minute);
                                final endDateTime = DateTime(
                                    selectedDate!.year,
                                    selectedDate!.month,
                                    selectedDate!.day,
                                    selectedTime.hour,
                                    selectedTime.minute);
                                if (endDateTime.isBefore(startDateTime)) {
                                  log('End time cannot be earlier than start time');
                                  return;
                                }
                              }
                              setState(() {
                                endAt.text = formatTimeOfDay(selectedTime);
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const MyAddDutiesLabel(
                            icon: Icons.person_outline_rounded,
                            label: 'Students'),
                        MyAddDutyField(
                            formKey: _formKeyStudent,
                            controller: students,
                            hintText: 'No. of Students',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter students';
                              }
                              return null;
                            })
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(),
                  )
                ],
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
                child: Form(
                  key: _formKeyMessage,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter message';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              MyButton(
                  onTap: () {
                    final validatedDate = _formKeyDate.currentState!.validate();
                    final validatedStartAt =
                        _formKeyStartAt.currentState!.validate();
                    final validatedEndAt =
                        _formKeyEndAt.currentState!.validate();
                    final validatedBuilding =
                        _formKeyBuilding.currentState!.validate();
                    final validatedStudents =
                        _formKeyStudent.currentState!.validate();
                    final validatedMessage =
                        _formKeyMessage.currentState!.validate();
                    if (validatedDate &&
                        validatedStartAt &&
                        validatedEndAt &&
                        validatedBuilding &&
                        validatedStudents &&
                        validatedMessage) {
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
                                  context.read<PostedDutiesBloc>(),
                              recentActivitiesBloc:
                                  context.read<RecentActivitiesBloc>(),
                            ),
                          );
                      Navigator.pop(context);
                    }
                  },
                  buttonText: 'Submit')
            ],
          ),
        ),
      ),
    );
  }
}
