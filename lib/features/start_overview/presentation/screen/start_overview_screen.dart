import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/start_overview/presentation/bloc/start_overview_bloc.dart';
import 'package:wellwave_frontend/features/start_overview/presentation/widget/start_recommend.dart';

class StartOverviewScreen extends StatelessWidget {
  final List<StartRecommend> pages = [
    const StartRecommend(
      title: AppStrings.metabolicSyndromeText,
      description: AppStrings.metabolicDescriptionText,
      imageUrl: AppImages.metabolicSyndromeImage,
      currentIndex: 0,
      totalPages: 3,
    ),
    const StartRecommend(
      title: AppStrings.metaEffectText,
      description: AppStrings.metaEffectDescriptionText,
      imageUrl: AppImages.metaEffectImage,
      currentIndex: 1,
      totalPages: 3,
    ),
    const StartRecommend(
      title: AppStrings.metaBehaviorText,
      description: AppStrings.metaBehaviorDescriptionText,
      imageUrl: AppImages.metaBehaviorImage,
      currentIndex: 2,
      totalPages: 3,
    ),
  ];

  StartOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: BlocBuilder<StartOverviewBloc, StartOverviewState>(
          builder: (context, state) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: state is PageNavigationState && state.currentIndex > 0
                  ? () {
                      debugPrint('Current Index: ${state.currentIndex}');
                      context
                          .read<StartOverviewBloc>()
                          .add(PreviousPageEvent());
                    }
                  : () {
                      context.goNamed(AppPages.splashName);
                    },
            );
          },
        ),
        actions: [
          BlocBuilder<StartOverviewBloc, StartOverviewState>(
            builder: (context, state) {
              final shouldShowSkip = state is PageNavigationState &&
                  state.currentIndex < pages.length - 1;
              return shouldShowSkip
                  ? TextButton(
                      onPressed: () {
                        context.goNamed(AppPages.homeName);
                      },
                      child: Text(
                        AppStrings.skipText,
                        style: Theme.of(context).textTheme.titleSmall,
                        selectionColor: AppColors.darkGrayColor,
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<StartOverviewBloc, StartOverviewState>(
            builder: (context, state) {
              if (state is PageNavigationErrorState) {
                return Center(
                  child: Text(
                    AppStrings.errorShow + state.errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                );
              }
              if (state is StartOverviewInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PageNavigationState) {
                return IndexedStack(
                  index: state.currentIndex,
                  children: List.generate(pages.length, (index) {
                    return StartRecommend(
                      title: pages[index].title,
                      description: pages[index].description,
                      imageUrl: pages[index].imageUrl,
                      currentIndex: state.currentIndex,
                      totalPages: pages.length,
                    );
                  }),
                );
              }

              return Container();
            },
          ),
          BlocBuilder<StartOverviewBloc, StartOverviewState>(
            builder: (context, state) {
              String buttonText = AppStrings.nextText;

              if (state is PageNavigationState) {
                buttonText = _getButtonText(state.currentIndex, pages.length);
              }
              return Padding(
                padding: const EdgeInsets.only(top: 64),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state is PageNavigationState
                          ? () {
                              if (state.currentIndex < 0) {
                                context.goNamed(AppPages.splashName);
                              } else if (state.currentIndex >=
                                  pages.length - 1) {
                                context.goNamed(AppPages.homeName);
                              } else {
                                context
                                    .read<StartOverviewBloc>()
                                    .add(NextPageEvent());
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.whiteColor,
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

String _getButtonText(int currentIndex, int totalPages) {
  return currentIndex >= totalPages - 1
      ? AppStrings.enterText
      : AppStrings.nextText;
}
