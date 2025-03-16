import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

import '../../../../common/widget/app_bar.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_images.dart';
import '../../../profile/presentation/widget/profile/success_dialog.dart';
import '../bloc/exchange_bloc.dart';
import '../bloc/exchange_event.dart';
import '../bloc/exchange_state.dart';
import '../widget/exchange_item_component.dart';

class MyItemScreen extends StatelessWidget {
  const MyItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ExchangeBloc>(context).add(FetchUserItemEvent());

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
                      BlocBuilder<ExchangeBloc, ExchangeState>(
                        builder: (context, state) {
                          if (state is ExchangeUserItemLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is ExchangeError) {
                            return Center(child: Text(state.errorMessage));
                          } else if (state is ExchangeUserItemLoaded) {
                            final exchangeItems = state.userExchange.items;

                            // Debug each item thoroughly
                            for (int i = 0; i < exchangeItems.length; i++) {
                              final item = exchangeItems[i].item;
                              debugPrint(
                                  "Item $i - ITEM_TYPE: '${item.itemType}'");
                              debugPrint(
                                  "Item $i - ExpBooster: ${item.expBooster}");
                              if (item.expBooster != null) {
                                debugPrint(
                                    "Item $i - Multiplier: ${item.expBooster!.boostMultiplier}");
                              }
                              debugPrint(
                                  "Item $i - GemExchange: ${item.gemExchange}");
                              if (item.gemExchange != null) {
                                debugPrint(
                                    "Item $i - Gem reward: ${item.gemExchange!.gemReward}");
                              }
                            }

                            return Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              alignment: WrapAlignment.spaceBetween,
                              children:
                                  exchangeItems.asMap().entries.map((entry) {
                                final int index = entry.key; // Get the index
                                final exchangeItem =
                                    entry.value; // Get the item
                                // debugPrint(
                                //     "Parsed ItemType: ${exchangeItem.item.itemType}");
                                // debugPrint(
                                //     "Parsed ExpBooster: ${exchangeItem.item.expBooster?.boostMultiplier}");
                                // debugPrint(
                                //     "Parsed GemExchange: ${exchangeItem.item.gemExchange?.gemReward}");

                                return ExchangeItemComponent(
                                  itemImagePath:
                                      exchangeItem.item.itemType == "exp_boost"
                                          ? AppImages.boostIcon
                                          : AppImages.gemIcon,
                                  requiredImagePath:
                                      exchangeItem.item.itemType == "exp_boost"
                                          ? AppImages.gemIcon
                                          : AppImages.expCoinSvg,
                                  itemValue:
                                      exchangeItem.item.itemType == "exp_boost"
                                          ? (exchangeItem.item.expBooster
                                                      ?.boostMultiplier ??
                                                  0.0)
                                              .toDouble()
                                          : (exchangeItem.item.gemExchange
                                                      ?.gemReward ??
                                                  0)
                                              .toDouble(),
                                  dayBoost: exchangeItem.item.itemType ==
                                          "exp_boost"
                                      ? exchangeItem.item.expBooster?.boostDays
                                      : null,
                                  requiredValue:
                                      exchangeItem.item.itemType == "exp_boost"
                                          ? exchangeItem.item.priceGem
                                          : exchangeItem.item.priceExp,
                                  onButtonClick: () {
                                    debugPrint(
                                        "${exchangeItem.itemId}Blue button clicked!");
                                    debugPrint(
                                        "${exchangeItem.item.itemName} ${exchangeItem.item.expBooster?.boostMultiplier} ${exchangeItem.item.expBooster?.boostDays} ${exchangeItem.item.gemExchange?.gemReward} ${exchangeItem.item.priceGem} ${exchangeItem.item.priceExp}");

                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return SuccessDialog(
                                          title: state.userExchange.items[index]
                                              .item.itemName,
                                          description: state.userExchange
                                              .items[index].item.description,
                                          iconPath: state
                                                      .userExchange
                                                      .items[index]
                                                      .item
                                                      .itemType ==
                                                  "exp_boost"
                                              ? AppImages.boostIcon
                                              : AppImages.gemIcon,
                                          onClose: () {
                                            // Close dialog first
                                            Navigator.of(context).pop();

                                            // Handle item activation if needed
                                            // if (state.itemType ==
                                            //     "gem_exchange") {
                                            //   context
                                            //       .read<ExchangeBloc>()
                                            //       .add(ActiveItemEvent(
                                            //           state.userItemId));
                                            // }

                                            // Update profile

                                            context
                                                .read<ExchangeBloc>()
                                                .add(FetchUserItemEvent());
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              }).toList(),
                            );
                          } else {
                            return const Center(
                                child: Text(AppStrings.noDataAvaliableText));
                          }
                        },
                      )
                    ],
                  )
                ]))));
  }
}
