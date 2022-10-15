import 'package:body_mass_index/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/pixel_ratio.dart';


class PrimaryButtonPortrait extends StatelessWidget {

  final String? buttonTitle;
  final VoidCallback onTap;
  const PrimaryButtonPortrait({Key? key,this.buttonTitle,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return  GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: heightRatio / fiftyPixelRatioH,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widthRatio / twelvePixelRatioW), color: buttonColor),
        child: Text(buttonTitle!,style: GoogleFonts.roboto(
          textStyle:   TextStyle(fontSize: heightRatio / twentyFivePixelRatioH,color: white,fontWeight: FontWeight.w700, ),
        ),),
      ),
    );
  }
}

class PrimaryButtonLandscape extends StatelessWidget {

  final String? buttonTitle;
  final VoidCallback onTap;
  const PrimaryButtonLandscape({Key? key,this.buttonTitle,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return  GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: widthRatio / fiftyPixelRatioH * 2,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widthRatio / thirtyTwoPixelRatioW), color: buttonColor),
        child: Text(buttonTitle!,style: GoogleFonts.roboto(
          textStyle:   TextStyle(fontSize: widthRatio / twentyFivePixelRatioH * 2,color: white,fontWeight: FontWeight.w700, ),
        ),),
      ),
    );
  }
}
