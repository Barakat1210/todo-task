import 'package:flutter/material.dart';

import '../../core/colors_manager.dart';
import '../../core/my_text_styles.dart';
class MyTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    primaryColor: ColorsManager.blueColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.blueColor,
      elevation: 4,
      centerTitle: true,
      titleTextStyle: MyTextStyles.appBarTextStyle
    ),
    scaffoldBackgroundColor: ColorsManager.scaffoldBgColor,
    bottomAppBarTheme: BottomAppBarTheme(
      color: ColorsManager.whiteColor,
      shape: CircularNotchedRectangle(),
      elevation: 14,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: ColorsManager.blueColor,
      unselectedItemColor: ColorsManager.greyColor,
      elevation: 0,
      selectedIconTheme: IconThemeData(
        size: 32,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
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
    textTheme: TextTheme(titleMedium: MyTextStyles.cardTitleTextStyle,
    labelSmall: MyTextStyles.settingsItemLabelTextStyle,
    ),
  );
}
