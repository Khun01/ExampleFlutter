import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/student/renewal/imagePicker/image_picker_bloc.dart';
import 'package:help_isko/presentation/bloc/student/renewal/renewal_form/renewal_form_bloc.dart';
import 'package:help_isko/presentation/pages/students/secondPage/renewalForm/preview_renew_form_page.dart';
import 'package:help_isko/presentation/pages/students/secondPage/renewalForm/requirements_renew_form_page.dart';
import 'package:help_isko/presentation/pages/students/secondPage/renewalForm/submit_renew_form_page.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/repositories/student/secondpage/renewal_form_repository.dart';
import 'package:help_isko/services/student/homepage/renewal_form_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class RenewFormPage extends StatefulWidget {
  const RenewFormPage({super.key});

  @override
  State<RenewFormPage> createState() => _RenewFormPageState();
}

class _RenewFormPageState extends State<RenewFormPage> {
  String? studNumber;
  int? attendedEvent;
  int? sharedPost;
  int? dutyHours;
  String? registrationFeePic;

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
    final RenewalFormBloc renewalFormBloc = RenewalFormBloc(
        renewalFormRepository: RenewalFormRepository(
            renewalFormService: RenewalFormService(baseUrl: baseUrl)));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => imagePickerBloc,
        ),
        BlocProvider(
          create: (context) => renewalFormBloc,
        ),
      ],
      child: BlocConsumer<ImagePickerBloc, ImagePickerState>(
        bloc: imagePickerBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
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
                    unreachedStepBorderColor: const Color(0x306BB577),
                    unreachedStepBorderType: BorderType.normal,
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
                  ),
                  Expanded(
                    child: activeStep == 0
                        ? BlocProvider.value(
                            value: imagePickerBloc,
                            child: RequirementsRenewFormPage(
                              onNextStep: (string1, string2, string3, string4,
                                  string5) {
                                studNumber = string1;
                                attendedEvent = string2;
                                sharedPost = string3;
                                dutyHours = string4;
                                registrationFeePic = string5;
                                nextStep();
                              },
                            ),
                          )
                        : activeStep == 1
                            ? BlocProvider.value(
                                value: imagePickerBloc,
                                child: SubmitRenewFormPage(
                                  onNextStep: nextStep,
                                  onFirstStep: goToFirstStep,
                                  studNumber: studNumber ?? '',
                                  attendEvent: attendedEvent ?? 0,
                                  sharedPost: sharedPost ?? 0,
                                  dutyHours: dutyHours ?? 0,
                                  registrationFeePic: registrationFeePic,
                                ),
                              )
                            : MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                    value: imagePickerBloc,
                                  ),
                                  BlocProvider.value(
                                    value: renewalFormBloc,
                                  ),
                                ],
                                child: PreviewRenewFormPage(
                                  studNumber: studNumber ?? '',
                                  attendEvent: attendedEvent ?? 0,
                                  sharedPost: sharedPost ?? 0,
                                  dutyHours: dutyHours ?? 0,
                                  registrationFeePic: registrationFeePic,
                                ),
                              ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
