import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/exchange/presentation/bloc/exchange_bloc.dart';
import 'package:wellwave_frontend/features/exchange/presentation/widget/exchange_item_component.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_bloc/profile_event.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_pages.dart';
import '../../../profile/presentation/bloc/profile_bloc/profile_state.dart';
import '../widget/exp_gem_component.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key});

  // void initState() {

  // }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(FetchUserProfile());

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        context: context,
        onLeading: true,
        backgroundColor: AppColors.transparentColor,
        title: '',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 44),
          child: Column(
            children: [
              //top
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    final profile = state.userProfile;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ExpGemComponent(
                            imagePath: AppImages.expCoinSvg,
                            value: profile.exp,
                          ),
                          const SizedBox(
                            width: 22,
                          ),
                          ExpGemComponent(
                            imagePath: AppImages.gemSvg,
                            value: profile.gem,
                          ),
                        ],
                      ),
                    );
                  } else if (state is ProfileError) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(
                        child: Text(AppStrings.noDataAvaliableText));
                  }
                },
              ),

              //my item
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.grey),
                    ),
                    onPressed: () {
                      context.goNamed(AppPages.logHistoryName);
                    },
                    child: Text(
                      AppStrings.myItemText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        shadows: [
                          const Shadow(
                              color: Colors.transparent, offset: Offset(0, 5))
                        ],
                        color: AppColors.greyColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),

              //gachapon
              Padding(
                padding: const EdgeInsets.only(bottom: 36),
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
