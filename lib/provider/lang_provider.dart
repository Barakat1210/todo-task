import 'package:flutter/material.dart';

class LangProvider extends ChangeNotifier {
  String currentLang = 'en';

  void updateLang(newLang) {
    if (currentLang == newLang) return;
    currentLang = newLang;
    notifyListeners();
  }
  bool isLangEnglish(){
    return currentLang=='en';
  }
}
