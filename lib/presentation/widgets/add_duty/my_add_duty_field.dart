import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAddDutyField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  const MyAddDutyField(
      {super.key,
      required this.formKey,
      required this.controller,
      required this.hintText,
      required this.validator,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.nunito(
                fontSize: 12, color: const Color(0x803B3B3B)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8)),
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }
}
