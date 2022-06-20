import 'package:flutter/material.dart';

import '../constant/color.dart';
import '../constant/pixel_ratio.dart';

class PlusMinusButton extends StatelessWidget {
  final Widget child;
  const PlusMinusButton({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return CircleAvatar(radius: widthRatio / sixteenPixelRatioW,backgroundColor: ass,child: child,);
    //   Container(
    //   alignment: Alignment.center,
    //   height: heightRatio / thirtyPixelRatioH,
    //   width: widthRatio / thirtyPixelRatioW,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(100),
    //     color: ass,
    //   ),
    //   child:  child,
    // );
  }
}
