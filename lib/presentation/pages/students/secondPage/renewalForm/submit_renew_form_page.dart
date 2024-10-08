import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';

class SubmitRenewFormPage extends StatelessWidget {
  final VoidCallback onNextStep;
  const SubmitRenewFormPage({super.key, required this.onNextStep});

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
                        onTap: () {},
                        child: const Icon(
                          Icons.edit,
                          color: Color(0xFF6BB577),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '00-0000-00000',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color(0xCC3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total Hours',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color(0xCC3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '1',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color(0xCC3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '1',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color(0xCC3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '1',
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
                      'ORF',
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
            onTap: () {
              onNextStep();
            },
            buttonText: 'Submit',
          )
        ],
      ),
    );
  }
}
