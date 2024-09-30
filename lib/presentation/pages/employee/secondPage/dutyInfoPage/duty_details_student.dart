import 'package:flutter/material.dart';
import 'package:help_isko/models/duty/students.dart';
import 'package:help_isko/presentation/cards/students_card.dart';

class DutyDetailsStudent extends StatelessWidget {
  final List<Students> students;
  const DutyDetailsStudent({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length, 
      itemBuilder: (context, index) {
        final student = students[index];
        return StudentsCard(
          profile: student.profile!,
          name: student.name!,
          course: student.course!,
        );
      },
    );
  }
}
