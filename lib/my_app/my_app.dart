import 'package:flutter/material.dart';

import '../config/theme/my_theme.dart';
import '../core/routes_manager.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute:RoutesManager.router ,
      initialRoute:RoutesManager.homeRoute ,
      theme:MyTheme.lightTheme ,
      themeMode:ThemeMode.light ,
    );
  }
}