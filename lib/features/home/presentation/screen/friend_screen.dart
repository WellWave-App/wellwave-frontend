import 'package:flutter/material.dart';

class FriendScreen extends StatelessWidget {
  const FriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'friend',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
