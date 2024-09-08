import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/components/my_add_duties_label.dart';
import 'package:help_isko/components/my_button.dart';

class MyAddDutyBottomDialog extends StatelessWidget {
  const MyAddDutyBottomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Duty Details',
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF6BB577)),
            ),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyAddDutiesLabel(
                        icon: Icons.apartment_rounded, label: 'Building'),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'PTC - 305',
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 12,
                                color: const Color(0x803B3B3B)),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8)),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyAddDutiesLabel(
                        icon: Icons.calendar_month_rounded, label: 'Date'),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'YYYY-MM-DD',
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 12,
                                color: const Color(0x803B3B3B)),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8)),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyAddDutiesLabel(
                        icon: Icons.alarm_rounded, label: 'Start at'),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'e.g., 09:00',
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 12,
                                color: const Color(0x803B3B3B)),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8)),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyAddDutiesLabel(
                        icon: Icons.alarm_rounded, label: 'End at'),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'e.g., 13:00',
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 12,
                                color: const Color(0x803B3B3B)),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8)),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const MyAddDutiesLabel(icon: Icons.person, label: 'Students'),
            SizedBox(
              width: 150,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'No. of Students',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 12,
                        color: const Color(0x803B3B3B)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8)),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 14,
                        color: const Color(0x803B3B3B)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(),
            const Spacer(),
            MyButton(
              onTap: (){
                Navigator.pop(context);
              }, 
              buttonText: 'Submit'
            )
          ],
        ),
      ),
    );
  }
}
