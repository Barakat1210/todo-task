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
      initialRoute:RoutesManager.loginRoute ,
      theme:MyTheme.light ,
      darkTheme:MyTheme.dark ,
      themeMode:ThemeMode.light ,
    );
  }
}