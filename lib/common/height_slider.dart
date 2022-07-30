import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/color.dart';
import '../constant/pixel_ratio.dart';

class HeightSlider extends StatefulWidget {
  late int height;
  final String? title;
  final double minValue;
  final double maxValue;
  late Function? onChanged;

  HeightSlider(
      {Key? key,
      this.height = 5,
      this.title,
      required this.minValue,
      required this.maxValue,
      this.onChanged})
      : super(key: key);

  @override
  State<HeightSlider> createState() => _HeightSliderState();
}

class _HeightSliderState extends State<HeightSlider> {
  @override
  Widget build(BuildContext context) {
    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return Container(
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
                value: widget.height.toDouble(),
                min: widget.minValue,
                max: widget.maxValue,
                onChanged: (double userInput) {
                 widget.height = userInput.round();
                }
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                widget.height.toString(),
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: heightRatio / twentyPixelRatioH,
                        color: white,
                        fontWeight: FontWeight.w700)),
              ),
              Text(
                widget.title!,
                style: TextStyle(
                    fontSize: heightRatio / twelvePixelRatioH, color: ass),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
