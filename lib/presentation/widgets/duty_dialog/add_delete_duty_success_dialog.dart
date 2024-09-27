import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/pages/wrapper.dart';
import 'package:ionicons/ionicons.dart';

class AddDeleteDutySuccessDialog extends StatelessWidget {
  final String blocUse;
  const AddDeleteDutySuccessDialog({super.key, required this.blocUse});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFFCFCFC),
            borderRadius: BorderRadius.circular(20)),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -70,
              left: 0,
              right: 0,
              child: Center(
                  child: Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: const Color(0xFFFCFCFC),
                    borderRadius: BorderRadius.circular(100)),
                child:
                    Image.asset('assets/images/duty_dialog_images/checked.png'),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 56, left: 16, right: 16, bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Success!',
                    style: GoogleFonts.nunito(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6BB577)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    blocUse == 'AddDuty'
                        ? 'Your new duty has been successfully created and saved.'
                        : blocUse == 'updateDuty'
                            ? 'Your duty has been successfully edited and saved.'
                            : 'Your duty has been successfully deleted.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        fontSize: 14, color: const Color(0xFF3B3B3B)),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        blocUse == 'AddDuty'
                            ? Navigator.pop(context)
                            : Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Wrapper(role: 'Employee')));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6BB577)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Go Back',
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFFCFCFC)),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Ionicons.arrow_undo,
                              color: Color(0xFFFCFCFC),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
