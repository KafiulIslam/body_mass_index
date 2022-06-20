import 'package:body_mass_index/screens/result_screen.dart';
import 'package:flutter/material.dart';

import '../model/calculating_bmi.dart';

class LoadingState extends StatefulWidget {
  final int height;
  final int weight;
  const LoadingState({Key? key, required this.height, required this.weight}) : super(key: key);

  @override
  State<LoadingState> createState() => _LoadingStateState();
}

class _LoadingStateState extends State<LoadingState> {


  @override
  void initState(){
    super.initState();
    _loadingState();
  }

  _loadingState() async{
    await Future.delayed(const Duration(microseconds: 5000),(){});
    BMICalculator calc = BMICalculator(height: widget.height, weight: widget.weight);
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ResultScreen( bmiResult: calc.calculateBMI(),
      resultText: calc.getResult(),
      interpretation: calc.getInterpretation(),)));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
