import 'package:flutter/material.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';

class MissionBox extends StatelessWidget {
  const MissionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, onLeading: true),
      body: Row(
        children: [
          Column(
            children: [],
          ),
          Column(
            children: [
              Row(),
              Row(),
              Row(),
            ],
          )
        ],
      ),
    );
  }
}
