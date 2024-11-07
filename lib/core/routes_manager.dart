import 'package:flutter/material.dart';
import 'package:todo_app/presentation/auth/login/login_screen.dart';
import 'package:todo_app/presentation/auth/register/register_screen.dart';

import '../presentation/screens/home/home_screen.dart';
class RoutesManager{
  static const String homeRoute="/home";
  static const String registerRoute="/register";
  static const String loginRoute="/login";
  static Route<MaterialPageRoute>?router(RouteSettings settings){
    switch(settings.name){
      case homeRoute:
        {
          return MaterialPageRoute(builder: (_)=>HomeScreen());
        }
      case registerRoute:
        {
          return MaterialPageRoute(builder: (_)=>RegisterScreen());
        }
      case loginRoute:
        {
          return MaterialPageRoute(builder: (context)=>LoginScreen());
        }
    }
  }
}