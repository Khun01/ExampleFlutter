import 'package:flutter/material.dart';

class SubmitRenewFormPage extends StatelessWidget {
  final VoidCallback onNextStep;
  const SubmitRenewFormPage({super.key, required this.onNextStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          onPressed: () {
            onNextStep();
          },
          child: Text('hehe')),
    );
  }
}
