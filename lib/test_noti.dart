import 'package:flutter/material.dart';

import 'common/widget/app_bar.dart';

class TestNotiScreen extends StatefulWidget {
  const TestNotiScreen({super.key});

  @override
  State<TestNotiScreen> createState() => _TestNotiScreenState();
}

class _TestNotiScreenState extends State<TestNotiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'noti', context: context, onLeading: true),
      body: const Center(child: Text('test noti')),
    );
  }
}
