import 'package:flutter/material.dart';

import '../../../../common/widget/app_bar.dart';

class TestNotiScreen extends StatelessWidget {
  const TestNotiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'noti', context: context, onLeading: true),
      body: const Center(child: Text('test noti')),
    );
  }
}
