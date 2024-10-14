import 'dart:developer';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/student/renewal/imagePicker/image_picker_bloc.dart';
import 'package:help_isko/presentation/bloc/student/renewal_form/renewal_form_bloc.dart';
import 'package:help_isko/presentation/pages/students/secondPage/renewalForm/preview_renew_form_page.dart';
import 'package:help_isko/presentation/pages/students/secondPage/renewalForm/requirements_renew_form_page.dart';
import 'package:help_isko/presentation/pages/students/secondPage/renewalForm/submit_renew_form_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:help_isko/repositories/student/secondpage/renewal_form_repository.dart';
import 'package:help_isko/services/student/homepage/renewal_form_service.dart';

class RenewFormPage extends StatefulWidget {
  const RenewFormPage({super.key});

  @override
  State<RenewFormPage> createState() => _RenewFormPageState();
}

class _RenewFormPageState extends State<RenewFormPage> {
  String? studentNumber;
  int? attendedEvents;
  int? sharedPosts;
  int? dutyHours;
  String? registrationFeePicture;

  int activeStep = 0;

  void nextStep() {
    if (activeStep < 2) {
      setState(() {
        activeStep++;
      });
    }
  }

  void goToFirstStep() {
    setState(() {
      activeStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ImagePickerBloc imagePickerBloc = ImagePickerBloc(ImagePicker());

    // Get the screen height and width using MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => RenewalFormRepository(
            renewalFormService: RenewalFormService(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => imagePickerBloc,
          ),
          BlocProvider(
            create: (context) => RenewalFormBloc(
              renewalFormRepository: RepositoryProvider.of<RenewalFormRepository>(context),
            ),
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.02,
                    left: screenWidth * 0.04,
                    right: screenWidth * 0.04,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          decoration: BoxDecoration(
                            color: const Color(0x1AA3D9A5),
                            borderRadius: BorderRadius.circular(20),
                          ),
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
                              fontSize: screenHeight * 0.025,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                EasyStepper(
                  activeStep: activeStep,
                  stepRadius: screenWidth * 0.07,
                  lineStyle: LineStyle(
                    lineLength: screenWidth * 0.1,
                    lineThickness: 3,
                    unreachedLineColor: const Color(0x306BB577),
                    finishedLineColor: const Color(0xFF6BB577),
                    activeLineColor: const Color(0xFF6BB577),
                  ),
                  stepShape: StepShape.circle,
                  stepBorderRadius: 15,
                  borderThickness: 2,
                  internalPadding: screenHeight * 0.01,
                  unreachedStepBackgroundColor: const Color(0x306BB577),
                  unreachedStepBorderColor: const Color(0x306BB577),
                  unreachedStepBorderType: BorderType.normal,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.03,
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
                                    fontSize: screenHeight * 0.02,
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
                          fontSize: screenHeight * 0.018,
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
                                    fontSize: screenHeight * 0.02,
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
                          fontSize: screenHeight * 0.018,
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
                                    fontSize: screenHeight * 0.02,
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
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: activeStep == 0
                      ? BlocProvider.value(
                          value: imagePickerBloc,
                          child: RequirementsRenewFormPage(
                            onNextStep: (studentNumber, attendedEvents, sharedPosts, dutyHours, registrationFeePicture) {
                              this.studentNumber = studentNumber;
                              this.attendedEvents = attendedEvents;
                              this.sharedPosts = sharedPosts;
                              this.dutyHours = dutyHours;
                              this.registrationFeePicture = registrationFeePicture;

                              log('Student Number: $studentNumber');
                              log('Attended Events: $attendedEvents');
                              log('Shared Posts: $sharedPosts');
                              log('Duty Hours: $dutyHours');
                              log('Registration Fee Picture: $registrationFeePicture');

                              nextStep();
                            },
                          ),
                        )
                      : activeStep == 1
                          ? SubmitRenewFormPage(
                              onNextStep: nextStep,
                              onFirstStep: goToFirstStep,
                              studentNumber: studentNumber ?? '',
                              attendedEvents: attendedEvents ?? 0,
                              sharedPosts: sharedPosts ?? 0,
                              dutyHours: dutyHours ?? 0,
                              registrationFeePicture: registrationFeePicture ?? '',
                              disbursementMethod: 'ORF',
                            )
                          : PreviewRenewFormPage(
                              studentNumber: studentNumber ?? '',
                              attendedEvents: attendedEvents ?? 0,
                              sharedPosts: sharedPosts ?? 0,
                              dutyHours: dutyHours ?? 0,
                              registrationFeePicture: registrationFeePicture ?? '',
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
