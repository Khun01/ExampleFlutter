import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/models/duty/prof_duty.dart';
import 'package:help_isko/presentation/bloc/employee/duty/delete/delete_duty_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/duty/update/update_duty_bloc.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/dutyInfoPage/duty_details.dart';
import 'package:help_isko/presentation/pages/employee/secondPage/dutyInfoPage/duty_details_student.dart';
import 'package:help_isko/presentation/widgets/duty_dialog/add_delete_duty_success_dialog.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_circular_progress_indicator.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/services/duty/duty_services.dart';
import 'package:ionicons/ionicons.dart';

class PostedDutyInfoPage extends StatelessWidget {
  final ProfDuty profDuty;
  const PostedDutyInfoPage({super.key, required this.profDuty});

  @override
  Widget build(BuildContext context) {
    final DeleteDutyBloc deleteDutyBloc =
        DeleteDutyBloc(dutyServices: DutyServices(baseUrl: baseUrl));
    final UpdateDutyBloc updateDutyBloc =
        UpdateDutyBloc(dutyServices: DutyServices(baseUrl: baseUrl));

    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteDutyBloc, DeleteDutyState>(
          bloc: deleteDutyBloc,
          listener: (context, state) {
            if (state is DeleteDutyFailedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is DeleteDutySuccessState) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) =>
                      const AddDeleteDutySuccessDialog(blocUse: 'deleteDuty'));
            }
          },
        ),
        BlocListener<UpdateDutyBloc, UpdateDutyState>(
          bloc: updateDutyBloc,
          listener: (context, state) {
            if (state is UpdateDutyFailedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is UpdateDutySuccessState) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) =>
                      const AddDeleteDutySuccessDialog(blocUse: 'updateDuty'));
            }
          },
        ),
      ],
      child: BlocBuilder<DeleteDutyBloc, DeleteDutyState>(
        bloc: deleteDutyBloc,
        builder: (context, deleteState) {
          return BlocBuilder<UpdateDutyBloc, UpdateDutyState>(
            bloc: updateDutyBloc,
            builder: (context, updateState) {
              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: SafeArea(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: const Color(0x1AA3D9A5),
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        'Duty Details',
                                        style: GoogleFonts.nunito(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF3B3B3B)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            TabBar(
                              tabs: const [
                                Tab(text: 'Duty'),
                                Tab(text: 'Students')
                              ],
                              labelStyle: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)),
                              indicatorColor: const Color(0xFF3B3B3B),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: deleteDutyBloc,
                                      ),
                                      BlocProvider.value(
                                        value: updateDutyBloc,
                                      ),
                                    ],
                                    child: DutyDetails(profDuty: profDuty),
                                  ),
                                  DutyDetailsStudent(students: profDuty.students!)
                                ],
                              ),
                            )
                          ],
                        ),
                        if (deleteState is DeleteDutyLoadingState ||
                            updateState is UpdateDutyLoadingState) ...[
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
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
