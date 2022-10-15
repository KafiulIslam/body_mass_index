import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:body_mass_index/screens/custom_splash_screen.dart';
import 'package:body_mass_index/screens/input_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'constant/color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: AnimatedSplashScreen(
          duration: 1000,
          splash: 'assets/images/bmi_app_logo.png',
          nextScreen: const InputScreen(),
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: Colors.white),
    );
  }
}
