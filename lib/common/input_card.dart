import 'package:body_mass_index/common/custom_card.dart';
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

  InputCardPortrait({
    Key? key,
    this.icon,
    this.title,
    this.cardType,
    this.number = 10,
    this.cardColor = inactiveCardColor,
    this.iconColor = ass,
    this.titleColor = ass,
    this.onChanged,
    this.sliderMaxValue = 200,
  }) : super(key: key);

  @override
  State<InputCardPortrait> createState() => _InputCardPortraitState();
}

class _InputCardPortraitState extends State<InputCardPortrait> {
  @override
  Widget build(BuildContext context) {
    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;
    return CustomCard(
        cardHeight: heightRatio / oneSixtyPixelRatioH,
        cardWidth: widthRatio / oneFiftyPixelRatioW,
        cardColor: widget.cardColor,
        cardChild:  widget.cardType == 1
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
              textStyle: TextStyle(
                  fontSize: heightRatio / twentyFivePixelRatioH,
                  color: widget.titleColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      )
          : Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                height: heightRatio / oneTwentyPixelRatioH,
                width: widthRatio / oneTwentyPixelRatioW,
                child: SleekCircularSlider(
                  max: widget.sliderMaxValue,
                  min: 10,
                  appearance: CircularSliderAppearance(
                    infoProperties: InfoProperties(
                      mainLabelStyle: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.transparent,
                            ),
                      ),
                      bottomLabelText: widget.title,
                      bottomLabelStyle: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: heightRatio / twentyFivePixelRatioH,
                            color: ass,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
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
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                widget.number.toString(),
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: heightRatio / twentyFivePixelRatioH,
                      color: white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ));
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
  final void Function(double)? onChanged;
  final double sliderMaxValue;

  InputCardLandscape({
    Key? key,
    this.icon,
    this.title,
    this.cardType,
    this.number = 10,
    this.cardColor = inactiveCardColor,
    this.iconColor = ass,
    this.titleColor = ass,
    this.onChanged,
    this.sliderMaxValue = 200,
  }) : super(key: key);

  @override
  State<InputCardLandscape> createState() => _InputCardLandscapeState();
}

class _InputCardLandscapeState extends State<InputCardLandscape> {

  @override
  Widget build(BuildContext context) {
    final widthRatio = MediaQuery.of(context).size.width;
    return CustomCard(
        cardHeight: widthRatio / oneSixtyPixelRatioH * 2,
        cardWidth: widthRatio / oneFiftyPixelRatioW,
        cardColor: widget.cardColor,
        cardChild: widget.cardType == 1
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
                textStyle: TextStyle(
                    fontSize: widthRatio / twentyFivePixelRatioH * 2,
                    color: widget.titleColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        )
            : Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: widthRatio / sixteenPixelRatioH * 2),
                child: SizedBox(
                  height: widthRatio / oneTwentyPixelRatioH * 2,
                  width: widthRatio / oneTwentyPixelRatioW,
                  child: SleekCircularSlider(
                    max: widget.sliderMaxValue,
                    min: 10,
                    appearance: CircularSliderAppearance(
                      infoProperties: InfoProperties(
                        mainLabelStyle: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: widthRatio / sixteenPixelRatioH * 2,
                            color: Colors.transparent,
                          ),
                        ),
                        bottomLabelText: widget.title,
                        bottomLabelStyle: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: widthRatio / twentyFivePixelRatioH * 2,
                              color: ass,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
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
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: widthRatio / sixteenPixelRatioH * 2),
                child: Text(
                  widget.number.toString(),
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: widthRatio / twentyFivePixelRatioH * 2,
                        color: white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),);
  }
}
