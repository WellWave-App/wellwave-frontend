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
                              child: BlocBuilder<ExchangeBloc, ExchangeState>(
                                builder: (context, state) {
                                  if (state is ExchangeUserItemLoading) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (state is ExchangeError) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Image.asset(AppImages.catNoItemimage,
                                            height: 128),
                                        Text(state.errorMessage),
                                      ],
                                    ));
                                  } else if (state is ExchangeUserItemLoaded) {
                                    final filteredItems = state
                                        .userExchange.items
                                        .where((item) =>
                                            item.isActive == true &&
                                            item.item.itemType == "exp_boost")
                                        .toList();

                                    if (filteredItems.isEmpty) {
                                      return const Center(
                                          child: Text(
                                              "No inactive experience boost items available"));
                                    }

                                    return Wrap(
                                      spacing: 16,
                                      runSpacing: 16,
                                      alignment: WrapAlignment.spaceBetween,
                                      children: filteredItems
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final int index = entry.key;
                                        final exchangeItem = entry.value;

                                        return ExchangeItemComponent(
                                          itemImagePath: AppImages
                                              .boostIcon, // Always boost icon since we're filtering for exp_boost
                                          itemValue: (exchangeItem
                                                      .item
                                                      .expBooster
                                                      ?.boostMultiplier ??
                                                  0.0)
                                              .toDouble(),
                                          dayBoost: exchangeItem
                                              .item.expBooster?.boostDays,
                                          onButtonClick: () {
                                            debugPrint(
                                                "${exchangeItem.itemId}Active button clicked!");

                                            context.read<ExchangeBloc>().add(
                                                ActiveItemEvent(
                                                    filteredItems[index]
                                                        .userItemId));

                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return SuccessDialog(
                                                  dayBoost: filteredItems[index]
                                                      .item
                                                      .expBooster
                                                      ?.boostDays,
                                                  dayBoostValue:
                                                      filteredItems[index]
                                                          .item
                                                          .expBooster
                                                          ?.boostMultiplier,
                                                  iconPath: AppImages.boostIcon,
                                                  onClose: () {
                                                    Navigator.of(context).pop();
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
                                        child: Text(
                                            AppStrings.noDataAvaliableText));
                                  }
                                },
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
                            return Center(
                                child: Column(
                              children: [
                                Image.asset(AppImages.catNoItemimage,
                                    height: 128),
                                const SizedBox(height: 32),
                                Text(state.errorMessage),
                              ],
                            ));
                          } else if (state is ExchangeUserItemLoaded) {
                            final filteredItems = state.userExchange.items
                                .where((item) =>
                                    item.isActive == false &&
                                    item.item.itemType == "exp_boost")
                                .toList();

                            if (filteredItems.isEmpty) {
                              return const Center(
                                  child: Text(
                                      "No inactive experience boost items available"));
                            }

                            return Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              alignment: WrapAlignment.spaceBetween,
                              children:
                                  filteredItems.asMap().entries.map((entry) {
                                final int index = entry.key;
                                final exchangeItem = entry.value;

                                return ExchangeItemComponent(
                                  itemImagePath: AppImages
                                      .boostIcon, // Always boost icon since we're filtering for exp_boost
                                  itemValue: (exchangeItem.item.expBooster
                                              ?.boostMultiplier ??
                                          0.0)
                                      .toDouble(),
                                  dayBoost:
                                      exchangeItem.item.expBooster?.boostDays,
                                  onButtonClick: () {
                                    debugPrint(
                                        "${exchangeItem.itemId}Active button clicked!");

                                    context.read<ExchangeBloc>().add(
                                        ActiveItemEvent(
                                            filteredItems[index].userItemId));

                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return SuccessDialog(
                                          dayBoost: filteredItems[index]
                                              .item
                                              .expBooster
                                              ?.boostDays,
                                          dayBoostValue: filteredItems[index]
                                              .item
                                              .expBooster
                                              ?.boostMultiplier,
                                          iconPath: AppImages.boostIcon,
                                          onClose: () {
                                            Navigator.of(context).pop();
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
