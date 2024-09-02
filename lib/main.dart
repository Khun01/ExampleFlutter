//Help, isKo

import 'package:flutter/material.dart';
import 'package:help_isko/screens/splash_screen.dart';
import 'package:help_isko/screens/verification_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VerificationPage(),
    );
  }
}
