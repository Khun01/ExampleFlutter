import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfessorHomePage extends StatelessWidget {
  const ProfessorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Prof Home Page'
          ),
        ),
      ),
    );
  }
}