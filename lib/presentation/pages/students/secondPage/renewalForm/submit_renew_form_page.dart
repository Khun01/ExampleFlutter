 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/presentation/bloc/student/renewal_form/renewal_form_bloc.dart';
import 'package:help_isko/presentation/bloc/student/renewal_form/renewal_form_event.dart';  
import 'package:help_isko/presentation/pages/students/secondPage/renewalForm/preview_renew_form_page.dart';

import 'dart:io';
// For the event


class SubmitRenewFormPage extends StatelessWidget {
  final VoidCallback onNextStep;
  final VoidCallback onFirstStep;
  
  // Collect all required data
  final String studentNumber;
  final int attendedEvents;
  final int sharedPosts;
  final int dutyHours;
  final String registrationFeePicture;
  final String disbursementMethod; 

  const SubmitRenewFormPage({
    super.key,
    required this.onNextStep,
    required this.onFirstStep,
    required this.studentNumber,
    required this.attendedEvents,
    required this.sharedPosts,
    required this.dutyHours,
    required this.registrationFeePicture,
    required this.disbursementMethod,
  });

  @override
  Widget build(BuildContext context) {
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
            child: Row(
              children: [
                Expanded(
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
                        'Shared Posts',
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
                      GestureDetector(
                        onTap: () {
                          onFirstStep();
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Color(0xFF6BB577),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Override the student number
                      Text(
                        studentNumber != '' ? studentNumber : '00-0000-00000',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color(0xCC3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Override the duty hours
                      Text(
                        dutyHours.toString(),
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color(0xCC3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Override the shared posts
                      Text(
                        sharedPosts.toString(),
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color(0xCC3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Override attended events
                      Text(
                        attendedEvents.toString(),
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color(0xCC3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Override the registration fee picture (just the filename)
                      Text(
                        registrationFeePicture,
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color(0xCC3B3B3B),
                        ),
                      ),
                    ],
                  ),
                )
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
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'Please select your preferred scholarship disbursement method.',
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
                  'Disbursement',
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
                      disbursementMethod,
                      style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6BB577)),
                    )
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
        MyButton(
  onTap: () async {
    // Convert the file paths to File objects only if a valid image is selected
    File? registrationFeePictureFile;
    File? disbursementMethodFile;

    // Commented out for now due to emulator limitations
    /*
    if (registrationFeePicture.isNotEmpty && registrationFeePicture != 'No image selected') {
      registrationFeePictureFile = File(registrationFeePicture);
    }

    if (disbursementMethod.isNotEmpty && disbursementMethod != 'No image selected') {
      disbursementMethodFile = File(disbursementMethod);
    }
    */

    // Dispatch the event to submit the form
    context.read<RenewalFormBloc>().add(
      SubmitRenewalFormEvent(
        studentNumber: studentNumber,
        attendedEvents: attendedEvents,
        sharedPosts: sharedPosts,
        dutyHours: dutyHours,
        registrationFeePicture: registrationFeePictureFile,  // Can be null for now
        disbursementMethod: disbursementMethodFile,           // Can be null for now
      ),
    );

    // Simulate a short delay
    await Future.delayed(const Duration(seconds: 1));

    try {
      // Fetch the form from the backend
      final fetchedForm = await context.read<RenewalFormBloc>().fetchSubmittedForm();

      // Check if fetchedForm is not null and contains valid data
      if (fetchedForm != null && fetchedForm.studentNumber != null) {
        // Navigate to the PreviewRenewFormPage with fetched data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreviewRenewFormPage(
              studentNumber: fetchedForm.studentNumber,
              attendedEvents: fetchedForm.attendedEvents,
              sharedPosts: fetchedForm.sharedPosts,
              dutyHours: fetchedForm.dutyHours,
              registrationFeePicture: fetchedForm.registrationFeePicture,
            ),
          ),
        );
      } else {
        // Handle the error if the form is null or invalid
        print("Fetched form or studentNumber is null");
      }
    } catch (e) {
      // Handle the error when fetching the form
      print('Error fetching form: $e');
    }

    // Move to the next step
    onNextStep();
  },
  buttonText: 'Submit',
)
        ],
      ),
    );
  }
}