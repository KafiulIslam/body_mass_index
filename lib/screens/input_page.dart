import 'package:body_mass_index/common/custom_orientation_builder.dart';
import 'package:body_mass_index/common/height_slider.dart';
import 'package:body_mass_index/common/input_card.dart';
import 'package:body_mass_index/common/primary_button.dart';
import 'package:body_mass_index/model/calculating_bmi.dart';
import 'package:body_mass_index/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/color.dart';
import '../constant/pixel_ratio.dart';

//height: 896;
//width: 414

class InputScreen extends StatefulWidget {

  const InputScreen({Key? key}) : super(key: key);

  static const String name = 'Input_screen';

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {


  int heightInFoot = 5;
  int heightInInch = 5;
  int weight = 50;
  int age = 20;
  int cardColorCode = 0;


  int changeFootToInc() {
    int height;
    int  heightInFootToInc = (heightInFoot * 12) ;
    height = (heightInFootToInc + heightInInch) ;
    return height;
  }



  @override
  Widget build(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return CustomOrientationBuilder(

        portrait: Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text(
          'BMI Meter',
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  fontSize: heightRatio / thirtyFivePixelRatioH,
                  color: white,
                  fontWeight: FontWeight.w700)),
        ),
      ),
      body: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: widthRatio / thirtyTwoPixelRatioW),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildGenderRowPortrait(context),
              _buildSliderPortrait(context),
              _buildWeightRowPortrait(context),
              PrimaryButtonPortrait(
                buttonTitle: 'Calculate',
                onTap: () {

                  BMICalculator calc = BMICalculator(height: changeFootToInc(), weight: weight);

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ResultScreen(
                      bmiResult: calc.calculateBMI(),
                      resultText: calc.getResult(),
                      interpretation: calc.getInterpretation(),
                    );

                  }
                  ));

                },
              ),
              SizedBox(
                height: heightRatio / sixteenPixelRatioH,
              ),
            ],
          ),
        ),
      ),
    ),

        landscape: Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text(
          'BMI Meter',
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  fontSize: widthRatio / thirtyFivePixelRatioH * 2,
                  color: white,
                  fontWeight: FontWeight.w700)),
        ),
      ),
      body: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: widthRatio / thirtyTwoPixelRatioW),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildGenderRowLandscape(context),
              _buildSliderLandscape(context),
              _buildWeightRowLandscape(context),
              PrimaryButtonLandscape(
                buttonTitle: 'Calculate',
                onTap: () {

                  BMICalculator calc = BMICalculator(height: changeFootToInc(), weight: weight);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ResultScreen(
                      bmiResult: calc.calculateBMI(),
                      resultText: calc.getResult(),
                      interpretation: calc.getInterpretation(),
                    );
                  }));


                },
              ),
              SizedBox(
                height: widthRatio / sixteenPixelRatioH * 2,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildGenderRowPortrait(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: heightRatio / thirtyTwoPixelRatioH,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  cardColorCode = 1;
                });
              },
              child: InputCardPortrait(
                title: 'Male',
                icon: Icons.male,
                cardType: 1,
                cardColor:
                    cardColorCode == 1 ? activeCardColor : inactiveCardColor,
                iconColor: cardColorCode == 1 ? white : ass,
                titleColor: cardColorCode == 1 ? white : ass,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  cardColorCode = 2;
                });
              },
              child: InputCardPortrait(
                title: 'Female',
                icon: Icons.female,
                cardType: 1,
                cardColor:
                    cardColorCode == 2 ? activeCardColor : inactiveCardColor,
                iconColor: cardColorCode == 2 ? white : ass,
                titleColor: cardColorCode == 2 ? white : ass,
              ),
            ),
          ],
        ),
        SizedBox(
          height: heightRatio / thirtyTwoPixelRatioH,
        ),
      ],
    );
  }
  Widget _buildGenderRowLandscape(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: widthRatio / thirtyTwoPixelRatioH * 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  cardColorCode = 1;
                });
              },
              child: InputCardLandscape(
                title: 'Male',
                icon: Icons.male,
                cardType: 1,
                cardColor:
                cardColorCode == 1 ? activeCardColor : inactiveCardColor,
                iconColor: cardColorCode == 1 ? white : ass,
                titleColor: cardColorCode == 1 ? white : ass,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  cardColorCode = 2;
                });
              },
              child: InputCardLandscape(
                title: 'Female',
                icon: Icons.female,
                cardType: 1,
                cardColor:
                cardColorCode == 2 ? activeCardColor : inactiveCardColor,
                iconColor: cardColorCode == 2 ? white : ass,
                titleColor: cardColorCode == 2 ? white : ass,
              ),
            ),
          ],
        ),
        SizedBox(
          height: widthRatio / thirtyTwoPixelRatioH * 2,
        ),
      ],
    );
  }


  Widget _buildSliderPortrait(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return Container(
      height: heightRatio / oneNinetyPixelRatioH,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widthRatio / sixteenPixelRatioW),
        color: inactiveCardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Height',
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: heightRatio / twentyFivePixelRatioH, color: ass)),
          ),

          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: white,
                  inactiveTrackColor: ass,
                  thumbColor: buttonColor,
                  overlayColor: Color(0x29EB1555),
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                ),
                child: Slider(
                    value: heightInFoot.toDouble(),
                    min: 2.0,
                    max: 10.0,
                    onChanged: (double userInput) {
                      setState(() {
                        heightInFoot = userInput.round();
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    heightInFoot.toString(),
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: heightRatio / twentyPixelRatioH,
                            color: white,
                            fontWeight: FontWeight.w700)),
                  ),
                  Text(
                    ' Foot',
                    style: TextStyle(
                        fontSize: heightRatio / sixteenPixelRatioH, color: ass,fontWeight: FontWeight.w900),
                  ),
                ],
              ),

            ],),
          ),

          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: white,
                    inactiveTrackColor: ass,
                    thumbColor: buttonColor,
                    overlayColor: Color(0x29EB1555),
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                  ),
                  child: Slider(
                      value: heightInInch.toDouble(),
                      min: 1.0,
                      max: 11.0,
                      onChanged: (double userInput) {
                        setState(() {
                          heightInInch = userInput.round();
                        });
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      heightInInch.toString(),
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: heightRatio / twentyPixelRatioH,
                              color: white,
                              fontWeight: FontWeight.w700)),
                    ),
                    Text(
                      ' Inch',
                      style: TextStyle(
                          fontSize: heightRatio / sixteenPixelRatioH, color: ass,fontWeight: FontWeight.w900),
                    ),
                  ],
                ),

              ],),
          ),


        ],
      ),
    );
  }
  Widget _buildSliderLandscape(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return Container(
      height: widthRatio / oneNinetyPixelRatioH * 2,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widthRatio / sixteenPixelRatioW),
        color: inactiveCardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Height',
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: widthRatio / twentyFivePixelRatioH * 2, color: ass)),
          ),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: white,
                    inactiveTrackColor: ass,
                    thumbColor: buttonColor,
                    overlayColor: Color(0x29EB1555),
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                  ),
                  child: Slider(
                      value: heightInFoot.toDouble(),
                      min: 2.0,
                      max: 10.0,
                      onChanged: (double userInput) {
                        setState(() {
                          heightInFoot = userInput.round();
                        });
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      heightInFoot.toString(),
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: heightRatio / twentyPixelRatioH,
                              color: white,
                              fontWeight: FontWeight.w700)),
                    ),
                    Text(
                      ' Foot',
                      style: TextStyle(
                          fontSize: heightRatio / sixteenPixelRatioH, color: ass,fontWeight: FontWeight.w900),
                    ),
                  ],
                ),

              ],),
          ),



          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: white,
                    inactiveTrackColor: ass,
                    thumbColor: buttonColor,
                    overlayColor: Color(0x29EB1555),
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                  ),
                  child: Slider(
                      value: heightInInch.toDouble(),
                      min: 1.0,
                      max: 11.0,
                      onChanged: (double userInput) {
                        setState(() {
                          heightInInch = userInput.round();
                        });
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      heightInInch.toString(),
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: heightRatio / twentyPixelRatioH,
                              color: white,
                              fontWeight: FontWeight.w700)),
                    ),
                    Text(
                      ' Inch',
                      style: TextStyle(
                          fontSize: heightRatio / sixteenPixelRatioH, color: ass),
                    ),
                  ],
                ),

              ],),
          ),
        ],
      ),
    );
  }


  Widget _buildWeightRowPortrait(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: heightRatio / thirtyTwoPixelRatioH,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InputCardPortrait(
              decreasingTap: (){
                setState((){
                  weight --;
                });
              },
              increasingTap: (){
                setState((){
                  weight ++;
                });
              },
              number: weight,
              title: 'Weight',
            ),
            InputCardPortrait(
              decreasingTap: (){
                setState((){
                  age --;
                });
              },
              increasingTap: (){
                setState((){
                  age ++;
                });
              },
              number: age,
              title: 'Age',
            ),
          ],
        ),
        SizedBox(
          height: heightRatio / thirtyTwoPixelRatioH,
        ),
      ],
    );
  }
  Widget _buildWeightRowLandscape(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return Column(
      children: [

        SizedBox(
          height: widthRatio / thirtyTwoPixelRatioH * 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InputCardLandscape(
              number: weight,
              title: 'Weight',
            ),
            InputCardLandscape(
              number: age,
              title: 'Age',
            ),
          ],
        ),
        SizedBox(
          height: widthRatio / thirtyTwoPixelRatioH * 2,
        ),

      ],
    );
  }

}
