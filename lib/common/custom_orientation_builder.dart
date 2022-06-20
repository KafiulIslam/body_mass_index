import 'package:flutter/material.dart';

class CustomOrientationBuilder extends StatelessWidget {

  final Widget portrait;
  final Widget landscape;

  const CustomOrientationBuilder(
      {Key? key, required this.portrait, required this.landscape})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (_, orientation) {
      if (orientation == Orientation.portrait) {
        return portrait;
      } else {
        return landscape;
      }
    });
  }
}
