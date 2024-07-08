import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:final_assignment/app/themes/app_theme.dart';
import 'package:final_assignment/features/home/presentation/view/connectivity_view.dart';
import 'package:final_assignment/features/splash/presentation/view/splash_view.dart';

import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getApplicationTheme(false),
      title: 'Glam Hire',
      home: const SplashView(),
      navigatorKey: AppNavigator.navigatorKey,
    );
  }
}
