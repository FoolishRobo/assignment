import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class ThemeDataClass {
  static ThemeData themeData = ThemeData(
    appBarTheme: AppBarTheme(color: AppColors.white),
    primaryColor: AppColors.backgroung,
    fontFamily: 'Noto-Sans',
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0))
              .w,
        ),
        indicatorColor: AppColors.blue,
        unselectedLabelColor: AppColors.unselectedlable,
        labelColor: AppColors.title,
        labelStyle: TextStyle(
          fontSize: 16.sp,
          fontFamily: AppFonts.ns500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16.sp,
          fontFamily: AppFonts.ns400,
        )),
    textTheme: TextTheme(
        headlineMedium: TextStyle(
            fontSize: 16.sp,
            letterSpacing: 3,
            fontFamily: AppFonts.ns400,
            color: AppColors.white),
        headlineSmall: TextStyle(
            fontSize: 24.sp,
            fontFamily: AppFonts.ns700,
            color: AppColors.title),
        headlineLarge: TextStyle(
            fontSize: 48.sp,
            fontFamily: AppFonts.ns700,
            color: AppColors.white),
        titleSmall: TextStyle(
            fontFamily: AppFonts.ns400,
            fontSize: 12.sp,
            color: AppColors.unselectedlable),
        titleLarge: TextStyle(
            fontFamily: AppFonts.ns600,
            fontSize: 14.sp,
            color: AppColors.black),
        titleMedium: TextStyle(
            fontFamily: AppFonts.ns400,
            fontSize: 12.sp,
            color: AppColors.unselectedlable),
        displayLarge: TextStyle(
            fontFamily: AppFonts.ns700,
            fontSize: 32.sp,
            color: AppColors.title),
        displayMedium: TextStyle(
            fontFamily: AppFonts.ns400,
            fontSize: 16.sp,
            color: AppColors.title),
        displaySmall: TextStyle(
            fontFamily: AppFonts.ns500,
            fontSize: 12.sp,
            color: AppColors.unselectedlable),
        bodySmall: TextStyle(
            fontFamily: AppFonts.ns400,
            fontSize: 14.sp,
            color: AppColors.title),
        bodyMedium: TextStyle(
            fontFamily: AppFonts.ns600,
            fontSize: 16.sp,
            color: AppColors.title),
        labelSmall: TextStyle(
            fontFamily: AppFonts.ns400,
            fontSize: 14.sp,
            color: AppColors.unselectedlable),
        labelMedium: TextStyle(
            fontFamily: AppFonts.ns500,
            fontSize: 14.sp,
            color: AppColors.title)),
  );
}
