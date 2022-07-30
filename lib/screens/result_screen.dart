import 'package:body_mass_index/common/custom_orientation_builder.dart';
import 'package:body_mass_index/common/primary_button.dart';
import 'package:body_mass_index/constant/color.dart';
import 'package:body_mass_index/constant/pixel_ratio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ResultScreen extends StatefulWidget {

  final String? bmiResult;
  final String? resultText;
  final String? interpretation;

  const ResultScreen({this.bmiResult, this.resultText, this.interpretation});

  static const String name = 'Input_screen';

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {




  @override
  Widget build(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return CustomOrientationBuilder(
        portrait: SafeArea(
          child: Scaffold(
      body: Padding(
          padding:   EdgeInsets.symmetric(horizontal: widthRatio / thirtyTwoPixelRatioW, ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  SizedBox(height: heightRatio/sixteenPixelRatioH,),
                Text(
                  'Result',
                  style: GoogleFonts.roboto(
                      textStyle:   TextStyle(
                          fontSize: heightRatio / thirtyFivePixelRatioH, color: white, fontWeight: FontWeight.w700)),
                ),
                  SizedBox(height: heightRatio/ sixteenPixelRatioH,),
                _buildResultBodyPortrait(context),
                  SizedBox(height: heightRatio/sixteenPixelRatioH,),
                PrimaryButtonPortrait(
                    buttonTitle: 'Re-Calculate',
                    onTap: () {
                      Navigator.pop(context);
                    }),
                SizedBox(height: heightRatio/sixteenPixelRatioH,),

              ],
            ),
          ),
      ),
    ),
        ),

        landscape: SafeArea(
          child: Scaffold(
            body: Padding(
              padding:   EdgeInsets.symmetric(horizontal: widthRatio / thirtyTwoPixelRatioW ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: widthRatio/sixteenPixelRatioH * 2,),
                    Text(
                      'Result',
                      style: GoogleFonts.roboto(
                          textStyle:   TextStyle(
                              fontSize: widthRatio / thirtyFivePixelRatioH * 2, color: white, fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(height: widthRatio/ sixteenPixelRatioH * 2,),
                    _buildResultBodyLandscape(context),
                    SizedBox(height: widthRatio/sixteenPixelRatioH * 2,),
                    PrimaryButtonLandscape(
                        buttonTitle: 'Re-Calculate',
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    SizedBox(height: widthRatio/sixteenPixelRatioH * 2,),

                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

 Widget _buildResultBodyPortrait(BuildContext context) {

   final heightRatio = MediaQuery.of(context).size.height;
   final widthRatio = MediaQuery.of(context).size.width;

    return   Container(
      height: heightRatio / fiveHundredPixelRatioH,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widthRatio/sixteenPixelRatioW),
        color: inactiveCardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.resultText!,
            style: GoogleFonts.roboto(
              textStyle:   TextStyle(fontSize: heightRatio/thirtyFivePixelRatioH, color: green,fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            widget.bmiResult!,
            style: GoogleFonts.roboto(
              textStyle:   TextStyle(fontSize: heightRatio/eightyPixelRatioH, color: white,fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            widget.interpretation!,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              textStyle:   TextStyle(fontSize: heightRatio/twentyPixelRatioH, color: white,fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
 }

 Widget _buildResultBodyLandscape(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return   Container(
      height: widthRatio / fiveHundredPixelRatioH * 2,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widthRatio/sixteenPixelRatioW),
        color: inactiveCardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.resultText!,
            style: GoogleFonts.roboto(
              textStyle:   TextStyle(fontSize: widthRatio/thirtyFivePixelRatioH * 2, color: green,fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            widget.bmiResult!,
            style: GoogleFonts.roboto(
              textStyle:   TextStyle(fontSize: widthRatio/eightyPixelRatioH * 2, color: white,fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            widget.interpretation!,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              textStyle:   TextStyle(fontSize: widthRatio/twentyPixelRatioH * 2, color: white,fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

}


