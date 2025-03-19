import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class ExchangeItemComponent extends StatelessWidget {
  final String itemImagePath;
  final String requiredImagePath;
  final double itemValue;
  final int? dayBoost;
  final int requiredValue;
  final VoidCallback onButtonClick;

  const ExchangeItemComponent({
    Key? key,
    required this.itemImagePath,
    required this.requiredImagePath,
    required this.itemValue,
    required this.requiredValue,
    required this.onButtonClick,
    this.dayBoost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 225,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 0),
              blurRadius: 4,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              itemImagePath,
              height: 73,
            ),
            const SizedBox(height: 12),
            dayBoost != null
                ? Column(
                    children: [
                      Text(
                        "$itemValue เท่า",
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(),
                      ),
                      Text(
                        "$dayBoost วัน",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 18),
                      )
                    ],
                  )
                : Text(
                    itemValue % 1 == 0
                        ? itemValue.toInt().toString()
                        : itemValue.toString(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(),
                  ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: onButtonClick,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 1),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(0, 2),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      requiredImagePath,
                      height: 21,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      requiredValue.toString(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
