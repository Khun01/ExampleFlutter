import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/pages/students/secondPage/renewalForm/preview_renew_form_page.dart';
import 'package:help_isko/presentation/pages/students/secondPage/renewalForm/requirements_renew_form_page.dart';
import 'package:help_isko/presentation/pages/students/secondPage/renewalForm/submit_renew_form_page.dart';
import 'package:ionicons/ionicons.dart';

class RenewFormPage extends StatefulWidget {
  const RenewFormPage({super.key});

  @override
  State<RenewFormPage> createState() => _RenewFormPageState();
}

class _RenewFormPageState extends State<RenewFormPage> {
  int activeStep = 0;

  void nextStep() {
    if (activeStep < 2) {
      setState(() {
        activeStep++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: const Color(0x1AA3D9A5),
                          borderRadius: BorderRadius.circular(20)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Ionicons.chevron_back_outline),
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
                        "Renewal Form",
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
            const SizedBox(height: 16),
            EasyStepper(
              activeStep: activeStep,
              stepRadius: 28,
              lineStyle: const LineStyle(
                lineLength: 50,
                lineType: LineType.normal,
                lineThickness: 3,
                lineSpace: 1,
                lineWidth: 10,
                unreachedLineType: LineType.normal,
                unreachedLineColor: Color(0x306BB577),
                finishedLineColor: Color(0xFF6BB577),
                activeLineColor: Color(0xFF6BB577),
              ),
              stepShape: StepShape.circle,
              stepBorderRadius: 15,
              borderThickness: 2,
              internalPadding: 10,
              unreachedStepBackgroundColor: const Color(0x306BB577),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              finishedStepBorderColor: const Color(0xFF6BB577),
              finishedStepTextColor: const Color(0xFF6BB577),
              finishedStepBackgroundColor: const Color(0xFF6BB577),
              activeStepIconColor: const Color(0xFF6BB577),
              activeStepBackgroundColor: const Color(0xFF6BB577),
              activeStepBorderColor: const Color(0xFF6BB577),
              showLoadingAnimation: false,
              steps: [
                EasyStep(
                  customStep: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Opacity(
                      opacity: activeStep >= 0 ? 1 : 0.3,
                      child: activeStep > 0
                          ? const Icon(
                              Icons.check_rounded,
                              size: 30,
                              color: Color(0xFFFCFCFC),
                            )
                          : Text(
                              '1',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFCFCFC),
                              ),
                            ),
                    ),
                  ),
                  customTitle: Text(
                    'Requirements',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B3B3B),
                    ),
                  ),
                ),
                EasyStep(
                  customStep: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Opacity(
                      opacity: activeStep >= 0 ? 1 : 0.3,
                      child: activeStep > 1
                          ? const Icon(
                              Icons.check_rounded,
                              size: 30,
                              color: Color(0xFFFCFCFC),
                            )
                          : Text(
                              '2',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFCFCFC),
                              ),
                            ),
                    ),
                  ),
                  customTitle: Text(
                    'Submit',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B3B3B),
                    ),
                  ),
                ),
                EasyStep(
                  customStep: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Opacity(
                      opacity: activeStep >= 0 ? 1 : 0.3,
                      child: activeStep >= 2
                          ? const Icon(
                              Icons.check_rounded,
                              size: 30,
                              color: Color(0xFFFCFCFC),
                            )
                          : Text(
                              '3',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFCFCFC),
                              ),
                            ),
                    ),
                  ),
                  customTitle: Text(
                    'Preview',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B3B3B),
                    ),
                  ),
                ),
              ],
              onStepReached: (index) => setState(() => activeStep = index),
            ),
            Expanded(
              child: activeStep == 0
                  ? RequirementsRenewFormPage(onNextStep: nextStep)
                  : activeStep == 1
                      ? SubmitRenewFormPage(onNextStep: nextStep)   
                      : const PreviewRenewFormPage(),
            )
          ],
        ),
      ),
    );
  }
}
