import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/models/duty/prof_duty.dart';
import 'package:help_isko/presentation/bloc/employee/duty/delete/delete_duty_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/duty/update/update_duty_bloc.dart';
import 'package:help_isko/presentation/widgets/add_duty/my_add_duty_field.dart';
import 'package:help_isko/presentation/widgets/add_duty/my_add_duty_label.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';

class DutyDetails extends StatefulWidget {
  final ProfDuty profDuty;
  const DutyDetails({super.key, required this.profDuty});

  @override
  State<DutyDetails> createState() => _DutyDetailsState();
}

class _DutyDetailsState extends State<DutyDetails> {
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

  @override
  void initState() {
    super.initState();
    date.text;
  }

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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const MyAddDutiesLabel(
                        icon: Icons.apartment_rounded,
                        label: 'Bulding',
                        fontWeight: FontWeight.bold),
                    const SizedBox(width: 8),
                    MyAddDutyField(
                        formKey: _formKeyBuilding,
                        controller: building,
                        hintText: widget.profDuty.building!,
                        hintColor: const Color(0xFF3B3B3B),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          return null;
                        }),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    const MyAddDutiesLabel(
                        icon: Icons.calendar_month_rounded,
                        label: 'Date',
                        fontWeight: FontWeight.bold),
                    const SizedBox(width: 8),
                    MyAddDutyField(
                        formKey: _formKeyDate,
                        controller: date,
                        hintText: widget.profDuty.date!,
                        hintColor: const Color(0xFF3B3B3B),
                        validator: (value) {
                          String pattern = r'^\d{4}-\d{2}-\d{2}$';
                          RegExp regExp = RegExp(pattern);
                          if (value == null || value.isEmpty) {
                            return null;
                          } else if (!regExp.hasMatch(value)) {
                            return 'Enter a valid date (YYYY-MM-DD)';
                          }
                          return null;
                        }),
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
                  children: [
                    const MyAddDutiesLabel(
                        icon: Icons.alarm_rounded,
                        label: 'Start at',
                        fontWeight: FontWeight.bold),
                    const SizedBox(width: 8),
                    MyAddDutyField(
                        formKey: _formKeyStartAt,
                        controller: startAt,
                        hintText: widget.profDuty.formattedStartTime,
                        hintColor: const Color(0xFF3B3B3B),
                        validator: (value) {
                          String pattern = r'^([01][0-9]|2[0-3]):[0-5][0-9]$';
                          RegExp regExp = RegExp(pattern);
                          if (value == null || value.isEmpty) {
                            return null;
                          } else if (!regExp.hasMatch(value)) {
                            return 'Enter a valid time in 24-hour format (HH:mm)';
                          }
                          return null;
                        })
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    const MyAddDutiesLabel(
                        icon: Icons.alarm_rounded,
                        label: 'End at',
                        fontWeight: FontWeight.bold),
                    const SizedBox(width: 8),
                    MyAddDutyField(
                        formKey: _formKeyEndAt,
                        controller: endAt,
                        hintText: widget.profDuty.formattedEndTime,
                        hintColor: const Color(0xFF3B3B3B),
                        validator: (value) {
                          String pattern = r'^([01][0-9]|2[0-3]):[0-5][0-9]$';
                          RegExp regExp = RegExp(pattern);
                          if (value == null || value.isEmpty) {
                            return null;
                          } else if (!regExp.hasMatch(value)) {
                            return 'Enter a valid time in 24-hour format (HH:mm)';
                          }
                          return null;
                        })
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
                  children: [
                    const MyAddDutiesLabel(
                        icon: Icons.person_outline_rounded,
                        label: 'Students',
                        fontWeight: FontWeight.bold),
                    MyAddDutyField(
                        formKey: _formKeyStudent,
                        controller: students,
                        hintText: widget.profDuty.maxScholars.toString(),
                        hintColor: const Color(0xFF3B3B3B),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
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
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20)),
            child: Form(
              key: _formKeyMessage,
              child: TextFormField(
                controller: message,
                decoration: InputDecoration(
                    hintText: widget.profDuty.message,
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 14, color: const Color(0xFF3B3B3B)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: InputBorder.none),
                maxLines: null,
                expands: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return null;
                  }
                  return null;
                },
              ),
            ),
          )),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: MyButton(
                    onTap: () {
                      context.read<DeleteDutyBloc>().add(
                          DeleteDutyButtonClickedEvent(
                              profDuty: widget.profDuty));
                    },
                    buttonText: 'Delete',
                    textColor: const Color(0xFF3B3B3B),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderColor: const Color(0xFF3B3B3B)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MyButton(
                    onTap: () {
                      final validatedDate =
                          _formKeyDate.currentState!.validate();
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
                        context.read<UpdateDutyBloc>().add(
                            UpdateDutyButtonClickedEvent(
                                building.text.isNotEmpty
                                    ? building.text
                                    : widget.profDuty.building!,
                                date.text.isNotEmpty
                                    ? date.text
                                    : widget.profDuty.date!,
                                startAt.text.isNotEmpty
                                    ? startAt.text
                                    : widget.profDuty.formattedStartTime,
                                endAt.text.isNotEmpty
                                    ? endAt.text
                                    : widget.profDuty.formattedEndTime,
                                message.text.isNotEmpty
                                    ? message.text
                                    : widget.profDuty.message!,
                                students.text.isNotEmpty
                                    ? students.text
                                    : widget.profDuty.maxScholars.toString(),
                                profDuty: widget.profDuty));
                      }
                    },
                    buttonText: 'Update'),
              )
            ],
          )
        ],
      ),
    );
  }
}
