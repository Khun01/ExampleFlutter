import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/student/renewal/renewal_form/renewal_form_bloc.dart';
import 'package:help_isko/presentation/bloc/student/renewal/renewal_form/renewal_form_event.dart';
import 'package:help_isko/presentation/bloc/student/renewal/renewal_form/renewal_form_state.dart';
import 'package:help_isko/presentation/widgets/duty_dialog/add_delete_duty_success_dialog.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_circular_progress_indicator.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';

class PreviewRenewFormPage extends StatelessWidget {
  final String orfUrl;
  final String studNumber;
  final int attendEvent;
  final String sharedPost;
  final int dutyHours;
  final String? registrationFeePic;
  const PreviewRenewFormPage(
      {super.key,
      required this.orfUrl,
      required this.studNumber,
      required this.attendEvent,
      required this.sharedPost,
      required this.dutyHours,
      required this.registrationFeePic});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RenewalFormBloc, RenewalFormState>(
      listener: (context, state) {
        if (state is RenewalFormSuccess) {
          Navigator.pop(context);
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) =>
                const AddDeleteDutySuccessDialog(blocUse: 'Renewal'),
          );
        } else if (state is RenewalFormLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const MyCircularProgressIndicator(),
          );
        } else if (state is RenewalFormFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0x303B3B3B)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Information Summary',
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Student number',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: const Color(0xCC3B3B3B),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Duty Hours',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: const Color(0xCC3B3B3B),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Attended Event',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: const Color(0xCC3B3B3B),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Shared Posts',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: const Color(0xCC3B3B3B),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Registration Fee Picture',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: const Color(0xCC3B3B3B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                studNumber != '' ? studNumber : '00-0000-00000',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: const Color(0xCC3B3B3B),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                dutyHours != 0
                                    ? dutyHours.toString()
                                    : 'Total Hours',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: const Color(0xCC3B3B3B),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                attendEvent != 0
                                    ? attendEvent.toString()
                                    : 'Attended Event',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: const Color(0xCC3B3B3B),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  sharedPost != ''
                                      ? sharedPost.toString()
                                      : 'Shared Post',
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: const Color(0xCC3B3B3B),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  registrationFeePic != ''
                                      ? registrationFeePic!
                                      : 'Registration Fee Picture',
                                  maxLines: 1,
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: const Color(0xCC3B3B3B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  'Please confirm and submit your form',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Text(
                  'Please confirm if the provided Official Receipt Form link is correct.',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: const Color(0x803B3B3B),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 130,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0x303B3B3B)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Official Receipt Form Proof',
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B)),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.cast_for_education_rounded,
                          color: Color(0xFF6BB577),
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'ORF',
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6BB577)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              orfUrl,
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFD9D9D9),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              MyButton(
                onTap: () {
                  context.read<RenewalFormBloc>().add(
                        SubmitRenewalFormEvent(
                            studentNumber: studNumber,
                            attendedEvents: attendEvent,
                            sharedPosts: sharedPost,
                            dutyHours: dutyHours,
                            registrationFeePicture: registrationFeePic),
                      );
                },
                buttonText: 'Submit',
              )
            ],
          ),
        );
      },
    );
  }
}
