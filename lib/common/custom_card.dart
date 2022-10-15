import 'package:flutter/material.dart';
import '../constant/color.dart';
import '../constant/pixel_ratio.dart';

class CustomCard extends StatelessWidget {
  final Widget cardChild;
  final double cardHeight;
  final double cardWidth;
  final Color cardColor;

  const CustomCard(
      {Key? key,
      required this.cardChild,
      required this.cardHeight,
      this.cardWidth = double.infinity,
      this.cardColor = inactiveCardColor
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthRatio = MediaQuery.of(context).size.width;
    return SizedBox(
        height: cardHeight,
        width: cardWidth,
        child: Card(
            color: cardColor,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(widthRatio / sixteenPixelRatioW)),
            ),
            child: cardChild));
  }
}
