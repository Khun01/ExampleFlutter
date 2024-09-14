import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyVerificationTextField extends StatelessWidget {
  final Function(String) onChanged;
  const MyVerificationTextField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 68,
      child: TextFormField(
        onChanged: (value) {
          onChanged(value);
          log('The token in the textField is; $value');
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
