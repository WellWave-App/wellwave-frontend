import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: appBarTheme(context),
      navigationBarTheme: navigationBarThemeData(context),
      primaryColor: AppColors.primaryColor,
      primaryColorDark: AppColors.secondaryDarkColor,
      textTheme: textTheme(context));
}

AppBarTheme appBarTheme(BuildContext context) {
  return AppBarTheme(
    color: AppColors.primaryColor,
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: AppColors.blackColor),
    titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: AppColors.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
  );
}

NavigationBarThemeData navigationBarThemeData(BuildContext context) {
  return const NavigationBarThemeData(
    height: 60,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    backgroundColor: AppColors.whiteColor,
    indicatorColor: Colors.transparent,
    indicatorShape: InputBorder.none,
  );
}

TextTheme textTheme(BuildContext context) {
  return const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor,
    ),
    titleLarge: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w600,
      color: AppColors.blackColor,
    ),
    titleMedium: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: AppColors.blackColor,
    ),
    titleSmall: TextStyle(
      fontFamily: 'NotoSansThai',
      color: AppColors.blackColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w500,
      fontSize: 24,
      color: AppColors.blackColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: AppColors.blackColor,
    ),
    labelSmall: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: AppColors.blackColor,
    ),
  );
}
