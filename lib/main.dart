import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:body_mass_index/screens/input_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'constant/color.dart';
import 'package:native_notify/native_notify.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NativeNotify.initialize(2826, 'XLJegk2AHmAwCP2qEwYjZr', null, null);
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
          backgroundColor: Colors.white ),
    );
  }
}
