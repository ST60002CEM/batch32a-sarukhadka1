import 'package:final_assignment/screen/dashboard_screen.dart';
import 'package:final_assignment/screen/login_screen.dart';
import 'package:final_assignment/screen/signup_page.dart';
import 'package:final_assignment/screen/splash_screen.dart';
import 'package:final_assignment/theme/theme_data.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glam Hire',
      theme: getApplicationTheme(),
      home: SplashScreen(),
    );
  }
}
