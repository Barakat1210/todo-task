import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_manager.dart';

class AppLightStyles {
  static TextStyle? AppBarTextStyle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: ColorsManager.whiteColor,
  );

  static TextStyle? cardTitleTextStyle =const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: ColorsManager.blueColor);
  static TextStyle? settingsItemLabelTextStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Color(0xFF303030),
  );
  static TextStyle? bottomSheetTitleStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Color(0xFF383838),
  );
  static TextStyle? greyStyle = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFA9A9A9));
  static TextStyle? TaskTitleStyle = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w700, color: ColorsManager.blueColor);
  static TextStyle? DateStyle = GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, color: ColorsManager.lightDateColor);
  static TextStyle? dropDownItemStyle = GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, color: ColorsManager.lightDateColor);
  static TextStyle? itemViewStyle = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w400, color: ColorsManager.blueColor);
  // TextStyle(
}
class AppDarkStyles {
static TextStyle? appBarTextStyle = const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: ColorsManager.whiteColor,
);
static TextStyle? cardTitleTextStyle =const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: ColorsManager.blueColor);
static TextStyle? settingsItemLabelTextStyle = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: ColorsManager.whiteColor,
);
static TextStyle? bottomSheetTitleStyle = GoogleFonts.poppins(
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: ColorsManager.whiteColor,
);
static TextStyle? greyStyle = GoogleFonts.inter(
    fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFA9A9A9));
static TextStyle? TaskTitleStyle = GoogleFonts.poppins(
    fontSize: 18, fontWeight: FontWeight.w700, color: ColorsManager.blueColor);
static TextStyle? dateStyle = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.w400, color: ColorsManager.whiteColor);
static TextStyle? dropDownItemStyle = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.w400, color: ColorsManager.whiteColor);
static TextStyle? itemViewStyle = GoogleFonts.inter(
    fontSize: 16, fontWeight: FontWeight.w400, color: ColorsManager.blueColor);
// TextStyle(
}
