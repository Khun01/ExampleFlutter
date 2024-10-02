import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final String role;
  const NotificationPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            role
          ),
        ),
      ),
    );
  }
}
