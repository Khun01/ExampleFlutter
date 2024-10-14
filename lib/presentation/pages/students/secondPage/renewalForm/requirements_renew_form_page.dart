import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/student/renewal/imagePicker/image_picker_bloc.dart';
import 'package:help_isko/presentation/widgets/my_button.dart';

class RequirementsRenewFormPage extends StatefulWidget {
  final void Function(String, int, int, int, String) onNextStep;
  const RequirementsRenewFormPage({super.key, required this.onNextStep});

  @override
  State<RequirementsRenewFormPage> createState() =>
      _RequirementsRenewFormPageState();
}

class _RequirementsRenewFormPageState extends State<RequirementsRenewFormPage> {
  final TextEditingController studNumber = TextEditingController();
  final TextEditingController attendedEvent = TextEditingController();
  final TextEditingController sharedPost = TextEditingController();
  final TextEditingController dutyHours = TextEditingController();

  final GlobalKey<FormState> _studNumber = GlobalKey<FormState>();
  final GlobalKey<FormState> _attendedEvent = GlobalKey<FormState>();
  final GlobalKey<FormState> _sharedPost = GlobalKey<FormState>();
  final GlobalKey<FormState> _dutyHours = GlobalKey<FormState>();

  @override
  void dispose() {
    studNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerBloc, ImagePickerState>(
      listener: (context, state) {},
      builder: (context, state) {
        String imageUrl;
        if (state is ImagePickerSuccess) {
          imageUrl = state.imageUrl;
        } else if (state is ImagePickerError) {
          imageUrl = state.error;
          log('The error in picking image is: ${state.error}');
        } else {
          imageUrl = 'No image selected';
        }
        return SingleChildScrollView(
          child: Center(
            child: Container(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
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
                  Form(
                    key: _studNumber,
                    child: TextFormField(
                      controller: studNumber,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your student number';
                        }
                        return null;
                      },
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
                  Form(
                    key: _attendedEvent,
                    child: TextFormField(
                      controller: attendedEvent,
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your attended event';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
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
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0x306BB577),
                        border: Border.all(
                          color: imageUrl != ''
                              ? Colors.transparent
                              : const Color(0xFFF44336),
                        ),
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
                                    context.read<ImagePickerBloc>().add(
                                        ImagePickerRemovedRequestedEvent());
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
                            Form(
                              key: _sharedPost,
                              child: TextFormField(
                                controller: sharedPost,
                                style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your shared post';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
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
                            Form(
                              key: _dutyHours,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: dutyHours,
                                style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your duty hours';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
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
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  MyButton(
                    onTap: () {
                      final validateStudNumber =
                          _studNumber.currentState!.validate();
                      final validateAttendedEvent =
                          _attendedEvent.currentState!.validate();
                      final validateSharedPost =
                          _sharedPost.currentState!.validate();
                      final validateDutyHours =
                          _dutyHours.currentState!.validate();
                      if (validateStudNumber &&
                          validateAttendedEvent &&
                          validateSharedPost &&
                          validateDutyHours) {
                        widget.onNextStep(
                            studNumber.text,
                            int.tryParse(attendedEvent.text) ?? 0,
                            int.tryParse(sharedPost.text) ?? 0,
                            int.tryParse(dutyHours.text) ?? 0,
                            imageUrl);
                      }
                    },
                    buttonText: 'Confirm and Continue',
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
