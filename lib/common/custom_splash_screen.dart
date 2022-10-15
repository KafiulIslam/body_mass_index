import 'dart:async';
import 'package:body_mass_index/constant/color.dart';
import 'package:body_mass_index/screens/input_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({Key? key}) : super(key: key);

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> with TickerProviderStateMixin {


  late AnimationController _animationController;
  late Animation<double> _animationLogo;
  late Animation<double> _animationText;


  @override
  void initState() {
    super.initState();
    animationExecution();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const InputScreen())));
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  void animationExecution(){

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));


    _animationLogo = Tween(begin: 0.00, end: 1.00).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.00, 0.35, curve: Curves.easeIn)));


    _animationText = CurvedAnimation(
        parent: _animationController,
        curve:
        const Interval(0.40, 0.70, curve: Curves.easeIn));

    _animationController.forward();

  }



  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery
        .of(context)
        .size
        .height;

    final double width = MediaQuery
        .of(context)
        .size
        .width;


    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: _animationLogo.value,
                        child: Image.asset('assets/images/bmi_app_logo.png',    height: height / 3,
                          width:  width / 1.5,)

                      ),
                      SizedBox(height: 5,),
                      Opacity(
                        opacity: _animationText.value,
                        child: Text(
                          'Check out your health condition',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.lobster(textStyle: const TextStyle(
                            color: brandColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          )),
                        ),
                      )
                    ],
                  )),
            ),
          );
        },
    );
  }
}
