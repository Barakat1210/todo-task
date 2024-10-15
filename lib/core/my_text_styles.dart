import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_manager.dart';

class MyTextStyles {
  static TextStyle? appBarTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: ColorsManager.whiteColor,
  );
  static TextStyle? cardTitleTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: ColorsManager.blueColor);
  static TextStyle? settingsItemLabelTextStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Color(0xFF303030),
  );
 // TextStyle(

}
