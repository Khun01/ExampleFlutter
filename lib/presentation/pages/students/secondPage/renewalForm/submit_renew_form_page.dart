import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/presentation/bloc/student/renewal_form/renewal_form_bloc.dart';
import 'package:help_isko/presentation/bloc/student/renewal_form/renewal_form_event.dart';
import 'package:help_isko/presentation/pages/students/secondPage/renewalForm/preview_renew_form_page.dart';

class SubmitRenewFormPage extends StatefulWidget {
  final VoidCallback onNextStep;
  final VoidCallback onFirstStep;

  // Form fields passed from the previous page
  final String studentNumber;
  final int attendedEvents;
  final int sharedPosts;
  final int dutyHours;
  final String registrationFeePicture; // This will be the path of the selected image from Requirements page
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
  _SubmitRenewFormPageState createState() => _SubmitRenewFormPageState();
}

class _SubmitRenewFormPageState extends State<SubmitRenewFormPage> {
  File? registrationFeePictureFile;

  @override
  void initState() {
    super.initState();
    // Load the image that was selected in the Requirements Page
    if (widget.registrationFeePicture.isNotEmpty) {
      registrationFeePictureFile = File(widget.registrationFeePicture);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: ListView(
        children: [
          // Form Summary Section
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0x303B3B3B)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Information Summary',
                      style: GoogleFonts.nunito(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                    // Pencil Icon - Goes back to Requirements Page
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: widget.onFirstStep, // Navigate back to Requirements Page
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                _buildInfoRow(context, 'Student Number', widget.studentNumber.isNotEmpty ? widget.studentNumber : '00-0000-00000'),
                _buildInfoRow(context, 'Duty Hours', widget.dutyHours.toString()),
                _buildInfoRow(context, 'Shared Posts', widget.sharedPosts.toString()),
                _buildInfoRow(context, 'Attended Events', widget.attendedEvents.toString()),
                _buildInfoRow(context, 'Registration Fee Picture', registrationFeePictureFile?.path ?? 'No image selected'),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.01),
            child: Text(
              'Please confirm and submit your form',
              style: GoogleFonts.nunito(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3B3B3B),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.01),
            child: Text(
              'Please select your preferred scholarship disbursement method.',
              style: GoogleFonts.nunito(
                fontSize: screenWidth * 0.035,
                color: const Color(0x803B3B3B),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          _buildDisbursementMethodContainer(context, screenWidth, screenHeight),
          SizedBox(height: screenHeight * 0.02),
          
          // Submit Button
          MyButton(
            onTap: () async {
              // Dispatch the event to submit the form with the registration fee picture
              context.read<RenewalFormBloc>().add(
                SubmitRenewalFormEvent(
                  studentNumber: widget.studentNumber,
                  attendedEvents: widget.attendedEvents,
                  sharedPosts: widget.sharedPosts,
                  dutyHours: widget.dutyHours,
                  registrationFeePicture: registrationFeePictureFile,  // File object to submit
                  disbursementMethod: null,           // No image picker here
                ),
              );

              await Future.delayed(const Duration(seconds: 1));

              try {
                final fetchedForm = await context.read<RenewalFormBloc>().fetchSubmittedForm();

                if (fetchedForm != null && fetchedForm.studentNumber != null) {
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
                  print("Fetched form or studentNumber is null");
                }
              } catch (e) {
                print('Error fetching form: $e');
              }

              widget.onNextStep();
            },
            buttonText: 'Submit',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.bold,
              color: const Color(0xCC3B3B3B),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.nunito(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3B3B3B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisbursementMethodContainer(BuildContext context, double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.15,
      padding: EdgeInsets.all(screenWidth * 0.03),
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
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3B3B3B),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(
                Icons.cast_for_education_rounded,
                color: Color(0xFF6BB577),
                size: 30,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                widget.disbursementMethod,
                style: GoogleFonts.nunito(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF6BB577),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
