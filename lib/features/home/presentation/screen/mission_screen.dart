import 'package:flutter/material.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'ภารกิจ',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
