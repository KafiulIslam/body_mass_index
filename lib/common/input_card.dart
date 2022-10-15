import 'package:body_mass_index/common/plus_minus_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../constant/color.dart';
import '../constant/pixel_ratio.dart';

class InputCardPortrait extends StatefulWidget {
  final IconData? icon;
  final String? title;
  final int? cardType;
  late int number;
  final Color cardColor;
  final Color iconColor;
  final Color titleColor;
  final void Function(double)? onChanged;
  final double sliderMaxValue;

  InputCardPortrait({Key? key,
      this.icon,
      this.title,
      this.cardType,
      this.number = 10,
      this.cardColor = inactiveCardColor,
      this.iconColor = ass,
      this.titleColor = ass,
    this.onChanged,
    this.sliderMaxValue = 200,
      })
      : super(key: key);

  @override
  State<InputCardPortrait> createState() => _InputCardPortraitState();
}

class _InputCardPortraitState extends State<InputCardPortrait> {
  @override
  Widget build(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return Container(
      height: heightRatio / oneSixtyPixelRatioH,
      width: widthRatio / oneFiftyPixelRatioW,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular( widthRatio / sixteenPixelRatioW ),
        color: widget.cardColor,
      ),
      child: widget.cardType == 1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  widget.icon,
                  color: widget.iconColor,
                  size: heightRatio / eightyPixelRatioH,
                ),
                Text(
                  widget.title!,
                  style: GoogleFonts.roboto(
                    textStyle:   TextStyle(
                        fontSize: heightRatio/ twentyFivePixelRatioH, color: widget.titleColor, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            )
          : Stack(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
            child: SizedBox(
              height: heightRatio / oneTwentyPixelRatioH,
              width: widthRatio / oneTwentyPixelRatioW,
              child: SleekCircularSlider(
                max: widget.sliderMaxValue,
              min: 10,
              appearance: CircularSliderAppearance(
                customWidths: CustomSliderWidths(
                  trackWidth: 4,
                  progressBarWidth: 6,
                  handlerSize: 10,
                ),
                customColors: CustomSliderColors(
                  trackColor: ass,
                  progressBarColor: white,
                  dotColor: buttonColor,
                  hideShadow: true,

                ),
              ),
                  onChange: widget.onChanged,
                  ),
            ),
          ),
                Center(
                  child: Text(
                    widget.number.toString(),
                    style: GoogleFonts.roboto(
                      textStyle:   TextStyle(
                          fontSize: heightRatio / twentyFivePixelRatioH,
                          color: white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      widget.title!,
                      style: GoogleFonts.roboto(
                        textStyle:   TextStyle(
                            fontSize: heightRatio/twentyFivePixelRatioH, color: ass, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding:   EdgeInsets.symmetric(horizontal: widthRatio / eightPixelRatioW),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       GestureDetector(
                //           onTap:  widget.decreasingTap,
                //           child: PlusMinusButton(
                //             child: Container(
                //               height: heightRatio / twoPixelRatioH,
                //               width: widthRatio / twelvePixelRatioW,
                //               color: brandColor,
                //             ),
                //           )),
                //       GestureDetector(
                //           onTap: widget.increasingTap,
                //           child: PlusMinusButton(
                //               child: Icon(
                //             Icons.add,
                //             size: heightRatio / twentyFivePixelRatioH,
                //             color: brandColor,
                //           ))),
                //     ],
                //   ),
                // ),
              ],
            ),
    );
  }
}



class InputCardLandscape extends StatefulWidget {
  final IconData? icon;
  final String? title;
  final int? cardType;
  late int number;
  final Color cardColor;
  final Color iconColor;
  final Color titleColor;

  InputCardLandscape({Key? key,
    this.icon,
    this.title,
    this.cardType,
    this.number = 10,
    this.cardColor = inactiveCardColor,
    this.iconColor = ass,
    this.titleColor = ass
  })
      : super(key: key);

  @override
  State<InputCardLandscape> createState() => _InputCardLandscapeState();
}

class _InputCardLandscapeState extends State<InputCardLandscape> {
  @override
  Widget build(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return Container(
      height: widthRatio / oneSixtyPixelRatioH * 2,
      width: widthRatio / oneFiftyPixelRatioW,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular( widthRatio / sixteenPixelRatioW ),
        color: widget.cardColor,
      ),
      child: widget.cardType == 1
          ? Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            widget.icon,
            color: widget.iconColor,
            size: widthRatio / eightyPixelRatioH * 2,
          ),
          Text(
            widget.title!,
            style: GoogleFonts.roboto(
              textStyle:   TextStyle(
                  fontSize: widthRatio / twentyFivePixelRatioH * 2, color: widget.titleColor, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.number.toString(),
            style: GoogleFonts.roboto(
              textStyle:   TextStyle(
                  fontSize: widthRatio / twentyFivePixelRatioH * 2,
                  color: white,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: widthRatio / eightPixelRatioW),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.number--;
                      });
                    },
                    child: PlusMinusButton(
                      child: Container(
                        height: widthRatio / twoPixelRatioH * 2,
                        width: widthRatio / twelvePixelRatioW,
                        color: brandColor,
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.number++;
                      });
                    },
                    child: PlusMinusButton(
                        child: Icon(
                          Icons.add,
                          size: widthRatio / twentyFivePixelRatioH * 2,
                          color: brandColor,
                        ))),
              ],
            ),
          ),
          Text(
            widget.title!,
            style: GoogleFonts.roboto(
              textStyle:   TextStyle(
                  fontSize: widthRatio/twentyFivePixelRatioH * 2, color: ass, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
