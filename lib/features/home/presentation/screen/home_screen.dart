import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Text(
        //   'home',
        //   style: Theme.of(context).textTheme.headlineLarge,
        child: TextButton(
            onPressed: () {
              context.goNamed(AppPages.exchangeName);
            },
            child: const Text('go to exchange screen')),
      ),
    );
  }
}
