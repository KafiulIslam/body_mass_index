import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:body_mass_index/screens/custom_splash_screen.dart';
import 'package:body_mass_index/screens/input_page.dart';
import 'package:flutter/foundation.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'BMI meter',
      theme: ThemeData(
        primaryColor: brandColor,
        scaffoldBackgroundColor: brandColor,
      ),

      home: const CustomSplashScreen(),
      // AnimatedSplashScreen(
      //     splash: Image.asset('assets/images/bmi_app_logo.png'),
      //     splashTransition: SplashTransition.scaleTransition,
      //     nextScreen: const InputScreen()),
    );
  }
}
