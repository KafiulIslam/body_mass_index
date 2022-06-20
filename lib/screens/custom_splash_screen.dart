import 'package:body_mass_index/constant/color.dart';
import 'package:body_mass_index/screens/input_page.dart';
import 'package:flutter/material.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({Key? key}) : super(key: key);

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToInputScreen();
  }

  void _navigateToInputScreen() async {
    await Future.delayed(const Duration(microseconds: 5000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => InputScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: brandColor,
        child: Center(
            child: Container(height: 300,width: 300,decoration: const BoxDecoration(
              color: white,
              image: DecorationImage(
                image: AssetImage('assets/images/bmi_app_logo.png'),fit: BoxFit.cover,
              )
            ),)),
      ),
    );
  }
}
