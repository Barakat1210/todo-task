import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/provider/lang_provider.dart';
import 'package:todo_app/provider/theme_provider.dart';

import '../config/theme/my_theme.dart';
import '../core/routes_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
      locale:Locale(context.watch<LangProvider>().currentLang),
      //Locale(context.watch<LangProvider>().currentLang) ,
      debugShowCheckedModeBanner: false,
      onGenerateRoute:RoutesManager.router ,
      initialRoute:RoutesManager.loginRoute ,
      theme:MyTheme.light ,
      darkTheme:MyTheme.dark ,
      themeMode:context.watch<ThemeProvider>().currentTheme ,
    );
  }
}