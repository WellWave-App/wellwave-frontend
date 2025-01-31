import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.goNamed(AppPages.findFriendName);
              },
              child: const Text('Go to Assessment'),
            ),
            ElevatedButton(
              onPressed: () {
                context.goNamed(AppPages.homeName);
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
