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
      fontSize: 20,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor,
      fontSize: 17,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor,
      fontSize: 16,
    ),
    titleLarge: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor,
      fontSize: 28,
    ),
    titleMedium: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: AppColors.blackColor,
    ),
    titleSmall: TextStyle(
      fontFamily: 'NotoSansThai',
      color: AppColors.blackColor,
      fontWeight: FontWeight.w700,
      fontSize: 15,
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
      fontSize: 17,
    ),
    bodySmall: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w500,
      fontSize: 13,
    ),
    labelLarge: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: AppColors.blackColor,
    ),
    labelSmall: TextStyle(
      fontFamily: 'NotoSansThai',
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: AppColors.blackColor,
    ),
    // caption1: TextStyle(
    //   fontFamily: 'NotoSansThai',
    //   fontWeight: FontWeight.w600,
    //   fontSize: 12,
    //   color: AppColors.blackColor,
    // ),
  );
}
