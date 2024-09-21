import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RewardCard extends StatelessWidget {
  final String iconPath;   
  final String amount;     
  final String unitLabel;  

  const RewardCard({
    Key? key,
    required this.iconPath,
    required this.amount,
    required this.unitLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(  // Include the Expanded widget here
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F0FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 47,
              width: 47,
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                Text(
                  amount,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  unitLabel,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
