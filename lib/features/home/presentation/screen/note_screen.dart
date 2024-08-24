import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'note',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
