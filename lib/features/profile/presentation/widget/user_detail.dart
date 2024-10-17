import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class UserDetailCard extends StatelessWidget {
  const UserDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    String userName = 'แจน';
    String gender = 'หญิง';
    int birthYear = 2545;
    double height = 50.5;
    double weight = 155;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: AppColors.whiteColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 70,
                      child: Text(AppStrings.userNameText,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold))),
                  Text(userName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith())
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFDFDFDF)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 70,
                      child: Text(AppStrings.genderText,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold))),
                  Text(gender,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith())
                ],
              ),
              GestureDetector(
                onTap: () {
                  context.goNamed(AppPages.friendName);
                },
                child: const Icon(
                  Icons.navigate_next_rounded,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFDFDFDF)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 70,
                      child: Text(AppStrings.birthYearText,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold))),
                  Text(birthYear.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith())
                ],
              ),
              GestureDetector(
                onTap: () {
                  context.goNamed(AppPages.friendName);
                },
                child: const Icon(
                  Icons.navigate_next_rounded,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFDFDFDF)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 70,
                      child: Text(AppStrings.weightText,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold))),
                  Text('$weight ${AppStrings.kgText}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith())
                ],
              ),
              GestureDetector(
                onTap: () {
                  context.goNamed(AppPages.friendName);
                },
                child: const Icon(
                  Icons.navigate_next_rounded,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFDFDFDF)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 70,
                      child: Text(AppStrings.heightText,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold))),
                  Text('$height ${AppStrings.cmText}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith())
                ],
              ),
              GestureDetector(
                onTap: () {
                  context.goNamed(AppPages.friendName);
                },
                child: const Icon(
                  Icons.navigate_next_rounded,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
