import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:body_mass_index/routing/app_router.dart';
import 'package:body_mass_index/screens/custom_splash_screen.dart';
import 'package:body_mass_index/screens/input_page.dart';
import 'package:flutter/material.dart';
import 'constant/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI meter',
      // routeInformationProvider: AppRouter.router.routeInformationProvider,
      // routeInformationParser: AppRouter.router.routeInformationParser,
      // routerDelegate: AppRouter.router.routerDelegate,

      theme: ThemeData(
        primaryColor: brandColor,
        scaffoldBackgroundColor: brandColor,
      ),

      home: AnimatedSplashScreen(
          splash: Image.asset('assets/images/bmi_app_logo.png'),
          splashTransition: SplashTransition.scaleTransition,
          nextScreen: const InputScreen()),
    );
  }
}
