import 'package:flutter/material.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'mission',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
