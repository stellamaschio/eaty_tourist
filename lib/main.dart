import 'package:eaty_tourist/pages/homepage.dart';
import 'package:eaty_tourist/pages/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eaty tourist',
      theme: ThemeData(
        primaryColor: Colors.greenAccent,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
      ),
      home: const Splash(),
    );
  }
}


