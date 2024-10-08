import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppStyleColors.backgroundColor,
    fontFamily: 'Catamaran',
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: AppStyleColors.white,
      ),
      actionsIconTheme: const IconThemeData(
        color: AppStyleColors.white,
      ),
      titleTextStyle:
          AppTextStyle.titleMd.copyWith(color: AppStyleColors.white),
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppStyleColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: AppTextStyle.textSm.copyWith(
        color: AppStyleColors.gray100,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppStyleColors.backgroundColor,
      selectedItemColor: AppStyleColors.primaryDefault,
      unselectedItemColor: AppStyleColors.gray200,
      selectedLabelStyle: AppTextStyle.textSm.copyWith(
        color: AppStyleColors.primaryDefault,
      ),
      unselectedLabelStyle: AppTextStyle.textSm.copyWith(
        color: AppStyleColors.gray200,
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppStyleColors.primaryDefault,
      onPrimary: AppStyleColors.primaryDefault,
      secondary: AppStyleColors.secondaryDefault,
      onSecondary: AppStyleColors.secondaryDefault,
      error: AppStyleColors.error,
      onError: AppStyleColors.error,
      surface: AppStyleColors.backgroundColor,
      onSurface: AppStyleColors.primaryDefault,
      background: AppStyleColors.backgroundColor,
      onBackground: AppStyleColors.backgroundColor,
    ),
  );
}
