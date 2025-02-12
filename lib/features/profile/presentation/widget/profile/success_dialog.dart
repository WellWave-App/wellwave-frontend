import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';

class SuccessDialog extends StatelessWidget {
  final String iconPath;
  final int reward;
  final VoidCallback onClose;

  const SuccessDialog({
    Key? key,
    required this.reward,
    required this.iconPath,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(21),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(21),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFB2D6E7).withOpacity(1),
                                offset: const Offset(0, 6),
                                blurRadius: 0,
                                spreadRadius: 0,
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 64.0, bottom: 48),
                          child: Column(
                            children: [
                              Text(AppStrings.youReceivedText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith()),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(iconPath, height: 36),
                                  const SizedBox(width: 4),
                                  Text(
                                    'x${reward.toString()}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 34),
                      GestureDetector(
                        onTap: onClose,
                        child: const Text(
                          AppStrings.closeWindowText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFFBFBFBF),
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFFBFBFBF),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset(AppImages.barSuccessImage),
            ],
          ),
        ),
      ),
    );
  }
}
