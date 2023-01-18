import 'package:flutter/material.dart';

class CustomLoaderOverlay extends StatelessWidget {
  const CustomLoaderOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight =  MediaQuery
        .of(context)
        .size
        .height;
    final double screenWidth =  MediaQuery
        .of(context)
        .size
        .width;
    return Container(
        height: screenHeight,
        width: double.infinity,
        color: Colors.white.withOpacity(0.3),child:  SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(color: Colors.white.withOpacity(0.8),strokeWidth: 6,)),);
  }
}