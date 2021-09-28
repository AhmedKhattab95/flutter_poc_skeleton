import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.white,
        secondaryHeaderColor:AppColors.black,
        backgroundColor: AppColors.darkColor,
        fontFamily: 'Montserrat',
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: AppColors.secondary,
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.lightColor,
          actionsIconTheme: IconThemeData(color: AppColors.lightColor, size: AppSizes.appBarIconSize, opacity: 1),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.primary),
          ),
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
        canvasColor: AppColors.darkPrimary,
        primaryColor: AppColors.darkPrimary,
        secondaryHeaderColor:AppColors.white,
        scaffoldBackgroundColor: AppColors.black,
        backgroundColor: AppColors.white,
        textTheme: ThemeData.dark().textTheme,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: AppColors.darkSecondary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: AppColors.lightColor,
          actionsIconTheme: IconThemeData(color: AppColors.white, size: AppSizes.appBarIconSize, opacity: 1),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.primary),
          ),
        ));
  }
}
