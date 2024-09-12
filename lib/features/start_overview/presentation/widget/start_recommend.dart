import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class StartRecommend extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final int currentIndex;
  final int totalPages;

  const StartRecommend({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.currentIndex,
    required this.totalPages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 72),
          Image.asset(imageUrl),
          const SizedBox(height: 48),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalPages, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: index == currentIndex ? 29.0 : 6.0,
                height: 6.0,
                decoration: BoxDecoration(
                  color: index == currentIndex
                      ? AppColors.secondaryDarkColor
                      : AppColors.blueGrayColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
