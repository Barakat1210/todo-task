import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/lang_provider.dart';
import 'package:todo_app/provider/theme_provider.dart';

import 'my_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: 'AIzaSyAFiuJdKhAa--H7ydJ1o7rb7-ntANmkVxY',
        appId: 'com.example.todo_app',
        messagingSenderId:'',
        projectId:'todo-c12')
  );
  await   FirebaseFirestore.instance.enableNetwork();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(),),
        ChangeNotifierProvider(create: (context) => LangProvider(),),
      ],
      child: MyApp()));
}