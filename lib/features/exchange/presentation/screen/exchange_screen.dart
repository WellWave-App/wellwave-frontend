import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/exchange/presentation/widget/exchange_item_component.dart';

import '../../../../config/constants/app_colors.dart';
import '../widget/exp_gem_component.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        context: context,
        onLeading: true,
        backgroundColor: AppColors.transparentColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 44),
          child: Column(
            children: [
              //top
              const Padding(
                padding: EdgeInsets.only(bottom: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ExpGemComponent(
                      imagePath: AppImages.expCoinSvg,
                      value: 150,
                    ),
                    SizedBox(
                      width: 22,
                    ),
                    ExpGemComponent(
                      imagePath: AppImages.gemSvg,
                      value: 50,
                    ),
                  ],
                ),
              ),

              //gachapon
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          AppStrings.randomBoxText,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                debugPrint("congrats!");
                              },
                              child: SvgPicture.asset(AppImages.giftSvg))
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //exchange
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppStrings.exchangeItemText,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      ExchangeItemComponent(
                        itemImagePath: AppImages.gemSvg,
                        requiredImagePath: AppImages.expCoinSvg,
                        itemValue: 15,
                        requiredValue: 1200,
                        onButtonClick: () {
                          debugPrint("Blue button clicked!");
                        },
                      ),
                      ExchangeItemComponent(
                        itemImagePath: AppImages.gemSvg,
                        requiredImagePath: AppImages.expCoinSvg,
                        itemValue: 20,
                        requiredValue: 1500,
                        onButtonClick: () {
                          debugPrint("Blue button clicked!");
                        },
                      ),
                      ExchangeItemComponent(
                        itemImagePath: AppImages.gemSvg,
                        requiredImagePath: AppImages.expCoinSvg,
                        itemValue: 50,
                        requiredValue: 4000,
                        onButtonClick: () {
                          debugPrint("Blue button clicked!");
                        },
                      ),
                      ExchangeItemComponent(
                        itemImagePath: AppImages.gemSvg,
                        requiredImagePath: AppImages.expCoinSvg,
                        itemValue: 100,
                        requiredValue: 7500,
                        onButtonClick: () {
                          debugPrint("Blue button clicked!");
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
