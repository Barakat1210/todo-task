import 'package:flutter/material.dart';

import '../presentation/screens/home_screen.dart';
class RoutesManager{
  static const String homeRoute="/home";
  static Route<MaterialPageRoute>?router(RouteSettings settings){
    switch(settings.name){
      case homeRoute:
        {
          return MaterialPageRoute(builder: (_)=>HomeScreen());
        }
    }
  }
}