import 'package:flutter/cupertino.dart';
import 'dart:math';

class BMICalculator {

  final int height;
  final int weight;
  late double _bmi;

  BMICalculator({ required this.height, required this.weight});


  String calculateBMI() {
  double  heightInMeter = ( height / 39.37007874016 ) ;
    _bmi = weight / pow(heightInMeter, 2)  ;
    return _bmi.toStringAsFixed(2);
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'OverWeight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'UnderWeight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'You have gain overweight which is slightly threatening for health. You must have some exercise regularly with a sound diet.';
    } else if (_bmi > 18.5) {
      return 'Your BMI result is quite satisfactory. Keep it up.';
    } else {
      return 'Your BMI result is not satisfactory enough. You should gain more weight to get healthy.';
    }
  }
}