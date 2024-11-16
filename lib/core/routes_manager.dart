import 'package:flutter/material.dart';
import 'package:todo_app/presentation/auth/login/login_screen.dart';
import 'package:todo_app/presentation/auth/register/register_screen.dart';
import 'package:todo_app/presentation/screens/home/edit_task/edit_screen.dart';

import '../presentation/screens/home/home_screen.dart';
class RoutesManager{
  static const String homeRoute="/home";
  static const String registerRoute="/register";
  static const String loginRoute="/login";
  static const String editRoute="/edit";

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
        case editRoute:
        {
          if (settings.arguments is Map<String, dynamic>) {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => EditScreen(
                taskId: args['taskId'],
                title: args['title'],
                description: args['description'],
                date: args['date'],
              ),
            );
          }}

}}}