import 'package:flutter/material.dart';
class ThemeProvider extends ChangeNotifier{
  ThemeMode currentTheme=ThemeMode.light;
   void updateAppTheme(ThemeMode newTheme){
     if(newTheme==currentTheme)return;
     currentTheme=newTheme;
   notifyListeners();
   }
  bool isLightTheme(){
     return currentTheme==ThemeMode.light;
  }
}
