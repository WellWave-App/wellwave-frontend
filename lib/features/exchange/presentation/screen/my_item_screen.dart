import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

import '../../../../common/widget/app_bar.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_images.dart';
import '../widget/exchange_item_component.dart';

class MyItemScreen extends StatelessWidget {
  const MyItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          context: context,
          onLeading: true,
          backgroundColor: AppColors.transparentColor,
          title: AppStrings.myItemText,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 122),
                child: Column(children: [
                  //using Item
                  Padding(
                    padding: const EdgeInsets.only(bottom: 36),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppStrings.activeText,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                spacing: 16,
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
                              ),
                            )),
                      ],
                    ),
                  ),

                  //all item
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            AppStrings.myAllItemText,
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
                ]))));
  }
}
