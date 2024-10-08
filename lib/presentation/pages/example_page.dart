import 'package:flutter/material.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_recent_activity_loading_indicator.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('hahahaha'),
            MyRecentActivityLoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
