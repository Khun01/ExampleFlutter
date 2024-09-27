import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/models/data/prof_duty.dart';
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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter building';
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
                        validator: (value) {
                          String pattern = r'^\d{4}-\d{2}-\d{2}$';
                          RegExp regExp = RegExp(pattern);
                          if (value == null || value.isEmpty) {
                            return 'Please enter date';
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
                        validator: (value) {
                          String pattern = r'^([01][0-9]|2[0-3]):[0-5][0-9]$';
                          RegExp regExp = RegExp(pattern);
                          if (value == null || value.isEmpty) {
                            return 'Please enter a time';
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
                        validator: (value) {
                          String pattern = r'^([01][0-9]|2[0-3]):[0-5][0-9]$';
                          RegExp regExp = RegExp(pattern);
                          if (value == null || value.isEmpty) {
                            return 'Please enter a time';
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
            children: [
              Expanded(
                child: Column(
                  children: [
                    const MyAddDutiesLabel(
                        icon: Icons.person_outline_rounded, label: 'Students', fontWeight: FontWeight.bold),
                    MyAddDutyField(
                        formKey: _formKeyStudent,
                        controller: students,
                        hintText: widget.profDuty.maxScholars.toString(),
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
                        fontSize: 14, color: const Color(0x803B3B3B)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          )),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: MyButton(
                    onTap: () {},
                    buttonText: 'Delete',
                    textColor: const Color(0xFF3B3B3B),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderColor: const Color(0xFF3B3B3B)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MyButton(onTap: () {}, buttonText: 'Update'),
              )
            ],
          )
        ],
      ),
    );
  }
}
