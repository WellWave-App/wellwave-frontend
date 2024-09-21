import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';


class RoundedText extends StatelessWidget {
  final String text; 

  const RoundedText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F0FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppImages.articleIcon,
                height: 16,
                width: 16,
              ),
              const SizedBox(width: 8),
              Text(
                text, // Use the passed text directly
                style: Theme.of(context).textTheme.bodySmall?.copyWith(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
