import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/models/duty/students.dart';
import 'package:help_isko/presentation/bloc/shared/message/message_bloc.dart';
import 'package:help_isko/presentation/cards/shared/students_card.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/studentProfilePage/student_info_page.dart';

class DutyDetailsStudent extends StatelessWidget {
  final List<Students> students;
  const DutyDetailsStudent({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        log('The stud is: ${student.name}');
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                      value: context.read<MessageBloc>(),
                      child: StudentInfoPage(students: student)),
                ),
              );
            },
            child: StudentsCard(
              profile: student.profile!,
              name: student.name!,
              course: student.course!,
              studentNumber: student.studentNumber.toString(),
              targetUserId: student.studentId,
            ));
      },
    );
  }
}
