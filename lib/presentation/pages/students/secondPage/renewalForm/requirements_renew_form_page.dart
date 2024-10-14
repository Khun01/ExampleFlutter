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
    String registrationFeePicture,
  ) onNextStep;

  final String? initialStudentNumber;
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
  State<RequirementsRenewFormPage> createState() => _RequirementsRenewFormPageState();
}

class _RequirementsRenewFormPageState extends State<RequirementsRenewFormPage> {
  late TextEditingController studNumberController;
  late TextEditingController attendedEventsController;
  late TextEditingController sharedPostsController;
  int? selectedDutyHour;

  String imageUrl = '';
  bool showScrollIndicator = false;

  @override
  void initState() {
    super.initState();
    studNumberController = TextEditingController(text: widget.initialStudentNumber ?? '');
    attendedEventsController = TextEditingController();
    sharedPostsController = TextEditingController();  // Add Shared Posts controller
    selectedDutyHour = widget.initialDutyHours ?? 25;  // Default to HK 25-50
    imageUrl = widget.initialRegistrationFeePicture ?? 'No image selected';
  }

  @override
  void dispose() {
    studNumberController.dispose();
    attendedEventsController.dispose();
    sharedPostsController.dispose();  // Dispose sharedPostsController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<ImagePickerBloc, ImagePickerState>(
      listener: (context, state) {
        if (state is ImagePickerSuccess) {
          setState(() {
            imageUrl = state.imageUrl;
          });
        } else if (state is ImagePickerError) {
          imageUrl = state.error;
          log('The error in picking image is: ${state.error}');
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 50) {
                  setState(() {
                    showScrollIndicator = false;
                  });
                } else if (scrollInfo.metrics.pixels > 50) {
                  setState(() {
                    showScrollIndicator = true;
                  });
                } else {
                  setState(() {
                    showScrollIndicator = false;
                  });
                }
                return true;
              },
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                children: [
                  _buildTextSection(
                      context, 'Select a disbursement method', 'Please select a disbursement method that is most convenient for you'),
                  SizedBox(height: screenHeight * 0.02),
                  _buildMethodChoice(screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildInputSection(context, 'Student Number', studNumberController, '00-0000-00000'),
                  SizedBox(height: screenHeight * 0.01),
                  _buildInputSection(context, 'Attended Events', attendedEventsController, ''), // Attended Events field
                  SizedBox(height: screenHeight * 0.01),
                  _buildInputSection(context, 'Shared Posts', sharedPostsController, ''), // Add Shared Posts input field
                  SizedBox(height: screenHeight * 0.01),
                  _buildRegistrationFeePictureSection(context),
                  SizedBox(height: screenHeight * 0.01),
                  _buildDropdownDutyHours(context),  // Add Dropdown for duty hours
                  SizedBox(height: screenHeight * 0.02),
                  MyButton(
                    onTap: () {
                      widget.onNextStep(
                        studNumberController.text,
                        int.parse(attendedEventsController.text.isNotEmpty ? attendedEventsController.text : '0'),
                        int.parse(sharedPostsController.text.isNotEmpty ? sharedPostsController.text : '0'),  // Add Shared Posts to onNextStep
                        selectedDutyHour ?? 25,
                        imageUrl,
                      );
                    },
                    buttonText: 'Confirm and Continue',
                  ),
                ],
              ),
            ),
            if (showScrollIndicator)
              Positioned(
                bottom: screenHeight * 0.03,
                right: screenWidth * 0.03,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    color: const Color(0xFF6BB577),
                    size: 28,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  // Dropdown for Duty Hours
  Widget _buildDropdownDutyHours(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.01),
          child: Text(
            'Duty Hours',
            style: GoogleFonts.nunito(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3B3B3B),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          decoration: BoxDecoration(
            color: const Color(0x306BB577),
            borderRadius: BorderRadius.circular(50),
          ),
          child: DropdownButtonFormField<int>(
            value: selectedDutyHour,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            ),
            items: [
              DropdownMenuItem(child: Text("HK25-50 REQUIRED DUTY HOURS"), value: 25),
              DropdownMenuItem(child: Text("HK50-90 REQUIRED DUTY HOURS"), value: 50),
              DropdownMenuItem(child: Text("HK75-120 REQUIRED DUTY HOURS"), value: 75),
            ],
            onChanged: (int? newValue) {
              setState(() {
                selectedDutyHour = newValue;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextSection(BuildContext context, String title, String description) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.nunito(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3B3B3B),
            ),
          ),
          Text(
            description,
            style: GoogleFonts.nunito(
              fontSize: screenWidth * 0.035,
              color: const Color(0x803B3B3B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodChoice(double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.06,
        vertical: screenWidth * 0.04,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF6BB577),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.cast_for_education,
            color: Color(0xFFFCFCFC),
          ),
          SizedBox(width: screenWidth * 0.02),
          Text(
            'ORF',
            style: GoogleFonts.nunito(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFCFCFC),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection(BuildContext context, String label, TextEditingController controller, String hintText) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.01),
          child: Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3B3B3B),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        SizedBox(
          height: screenHeight * 0.07,
          child: TextFormField(
            controller: controller,
            style: GoogleFonts.nunito(
              fontSize: screenWidth * 0.03,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3B3B3B),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.nunito(
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.bold,
                color: const Color(0x803B3B3B),
              ),
              fillColor: const Color(0x306BB577),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationFeePictureSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.01),
          child: Text(
            'Registration Fee Picture',
            style: GoogleFonts.nunito(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3B3B3B),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        GestureDetector(
          onTap: () {
            context.read<ImagePickerBloc>().add(ImagePickerRequestedEvent());
          },
          child: Container(
            height: screenHeight * 0.07,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
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
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                const Icon(
                  Icons.add_photo_alternate_rounded,
                  color: Color(0xFF6BB577),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
