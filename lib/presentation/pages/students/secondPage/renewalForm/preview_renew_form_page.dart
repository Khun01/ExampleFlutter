import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/widgets/duty_dialog/add_delete_duty_success_dialog.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';

class PreviewRenewFormPage extends StatelessWidget {
  final String studentNumber;
  final int attendedEvents;
  final int sharedPosts;
  final int dutyHours;
  final String registrationFeePicture;

  const PreviewRenewFormPage({
    super.key,
    required this.studentNumber,
    required this.attendedEvents,
    required this.sharedPosts,
    required this.dutyHours,
    required this.registrationFeePicture,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.03),
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
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            // Each row with label and value in the same line
                            _buildInfoRow('Student Number', studentNumber, context),
                            _buildInfoRow('Duty Hours', dutyHours.toString(), context),
                            _buildInfoRow('Shared Posts', sharedPosts.toString(), context),
                            _buildInfoRow('Attended Event', attendedEvents.toString(), context),
                            _buildInfoRow('Registration Fee Picture',
                                registrationFeePicture.isNotEmpty ? registrationFeePicture : 'No image selected', context),
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
                            fontSize: screenWidth * 0.04,
                            color: const Color(0x803B3B3B),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0x303B3B3B)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.cast_for_education_rounded,
                              color: Color(0xFF6BB577),
                              size: 30,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              'ORF',
                              style: GoogleFonts.nunito(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF6BB577),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Fixed button at the bottom
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: MyButton(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AddDeleteDutySuccessDialog(blocUse: 'Renewal'),
                  );
                },
                buttonText: 'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.nunito(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.bold,
                color: const Color(0xCC3B3B3B),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: GoogleFonts.nunito(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3B3B3B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
