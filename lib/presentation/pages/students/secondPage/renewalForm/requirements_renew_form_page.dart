import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/student/renewal/imagePicker/image_picker_bloc.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';

class RequirementsRenewFormPage extends StatefulWidget {
  final void Function(
    String studentNumber,
    int attendedEvents,
    int sharedPosts,
    int dutyHours,
    String registrationFeePicture
  ) onNextStep;

  final String? initialStudentNumber; // Pre-populated values
  final int? initialAttendedEvents;
  final int? initialSharedPosts;
  final int? initialDutyHours;
  final String? initialRegistrationFeePicture;

  const RequirementsRenewFormPage({
    super.key,
    required this.onNextStep,
    this.initialStudentNumber,
    this.initialAttendedEvents,
    this.initialSharedPosts,
    this.initialDutyHours,
    this.initialRegistrationFeePicture,
  });

  @override
  State<RequirementsRenewFormPage> createState() =>
      _RequirementsRenewFormPageState();
}

class _RequirementsRenewFormPageState extends State<RequirementsRenewFormPage> {
  late TextEditingController studNumberController;
  late TextEditingController attendedEventsController;
  late TextEditingController sharedPostsController;
  late TextEditingController dutyHoursController;

  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    studNumberController = TextEditingController(text: widget.initialStudentNumber ?? '');
    attendedEventsController = TextEditingController(text: widget.initialAttendedEvents?.toString() ?? '0');
    sharedPostsController = TextEditingController(text: widget.initialSharedPosts?.toString() ?? '0');
    dutyHoursController = TextEditingController(text: widget.initialDutyHours?.toString() ?? '0');
    imageUrl = widget.initialRegistrationFeePicture ?? 'No image selected';
  }

  @override
  void dispose() {
    studNumberController.dispose();
    attendedEventsController.dispose();
    sharedPostsController.dispose();
    dutyHoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerBloc, ImagePickerState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ImagePickerSuccess) {
          imageUrl = state.imageUrl;
        } else if (state is ImagePickerError) {
          imageUrl = state.error;
          log('The error in picking image is: ${state.error}');
        }

        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  'Select a disbursement method',
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
                  'Please select a disbursement method that is most convenient for you',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: const Color(0x803B3B3B),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF6BB577)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.cast_for_education,
                      color: Color(0xFFFCFCFC),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'ORF',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFCFCFC),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Student Number
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  'Student Number',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: studNumberController,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B),
                  ),
                  decoration: InputDecoration(
                    hintText: '00-0000-00000',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0x803B3B3B)),
                    fillColor: const Color(0x306BB577),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 1.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Attended Event
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  'Attended Event',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: attendedEventsController,
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B),
                  ),
                  decoration: InputDecoration(
                    fillColor: const Color(0x306BB577),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 1.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Registration Fee Picture
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  'Registration Fee Picture',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  context
                      .read<ImagePickerBloc>()
                      .add(ImagePickerRequestedEvent());
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0x306BB577),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            imageUrl,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      state is ImagePickerSuccess
                          ? GestureDetector(
                              onTap: () {
                                context
                                    .read<ImagePickerBloc>()
                                    .add(ImagePickerRemovedRequestedEvent());
                              },
                              child: const Icon(
                                Icons.close_rounded,
                                color: Color(0xFF6BB577),
                              ),
                            )
                          : const Icon(
                              Icons.add_photo_alternate_rounded,
                              color: Color(0xFF6BB577),
                              size: 24,
                            )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Shared Post',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: sharedPostsController,
                            style: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B),
                            ),
                            decoration: InputDecoration(
                              fillColor: const Color(0x306BB577),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Duty Hours',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: dutyHoursController,
                            style: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B),
                            ),
                            decoration: InputDecoration(
                              fillColor: const Color(0x306BB577),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Spacer(),
              // Proceed button
              MyButton(
                onTap: () {
                  widget.onNextStep(
                    studNumberController.text,
                    int.parse(attendedEventsController.text),
                    int.parse(sharedPostsController.text),
                    int.parse(dutyHoursController.text),
                    imageUrl,
                  );
                },
                buttonText: 'Confirm and Continue',
              ),
            ],
          ),
        );
      },
    );
  }
}
