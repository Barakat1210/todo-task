import 'package:flutter/material.dart';

import '../../core/colors_manager.dart';
import '../../core/my_text_styles.dart';

class MyTheme {
  static ThemeData light = ThemeData(
    indicatorColor: Colors.white,
    useMaterial3: false,
    primaryColor: ColorsManager.blueColor,
    appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.blueColor,
        elevation: 4,
        centerTitle: true,
        titleTextStyle: AppLightStyles.AppBarTextStyle),
    scaffoldBackgroundColor: ColorsManager.lightScaffoldBgColor,
    bottomAppBarTheme: BottomAppBarTheme(
      color: ColorsManager.whiteColor,
      shape: CircularNotchedRectangle(),
      elevation: 14,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: ColorsManager.blueColor,
      unselectedItemColor: ColorsManager.greyColor,
      elevation: 0,
      selectedIconTheme: IconThemeData(
        size: 32,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.blueColor,
      elevation: 12,
      iconSize: 26,
      shape: StadiumBorder(
        side: BorderSide(
          color: ColorsManager.whiteColor,
          width: 4,
        ),
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.transparent,
      elevation: 0,
    ),
    dividerColor: ColorsManager.blueColor,
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
    ),
    textTheme: TextTheme(
      titleMedium: AppLightStyles.cardTitleTextStyle,
      labelSmall: AppLightStyles.settingsItemLabelTextStyle,
      headlineMedium: AppLightStyles.bottomSheetTitleStyle,
    ),
  );
  static ThemeData dark = ThemeData(
    indicatorColor: Colors.black,
    useMaterial3: false,
    primaryColor: ColorsManager.blueColor,
    appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.blueColor,
        elevation: 4,
        centerTitle: true,
        titleTextStyle: AppLightStyles.AppBarTextStyle),
    scaffoldBackgroundColor: ColorsManager.blackAccent,
    bottomAppBarTheme: BottomAppBarTheme(
      color: ColorsManager.blackAccent,
      shape: CircularNotchedRectangle(),
      elevation: 14,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: ColorsManager.blueColor,
      unselectedItemColor: ColorsManager.greyColor,
      elevation: 0,
      selectedIconTheme: IconThemeData(
        size: 32,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.blackAccent,
      elevation: 12,
      iconSize: 26,
      shape: StadiumBorder(
        side: BorderSide(
          color: ColorsManager.whiteColor,
          width: 4,
        ),
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: ColorsManager.blackAccent,
      elevation: 20,
    ),
    dividerColor: ColorsManager.blueColor,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor:  ColorsManager.blackAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
    ),
    textTheme: TextTheme(
      titleMedium: AppLightStyles.cardTitleTextStyle,
      labelSmall: AppLightStyles.settingsItemLabelTextStyle,
      headlineMedium: AppLightStyles.bottomSheetTitleStyle,
    ),
  );
}
