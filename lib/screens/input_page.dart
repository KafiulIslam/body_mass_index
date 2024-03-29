import 'package:body_mass_index/common/custom_appbar.dart';
import 'package:body_mass_index/common/custom_card.dart';
import 'package:body_mass_index/common/custom_orientation_builder.dart';
import 'package:body_mass_index/common/input_card.dart';
import 'package:body_mass_index/common/primary_button.dart';
import 'package:body_mass_index/model/calculating_bmi.dart';
import 'package:body_mass_index/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../constant/color.dart';
import '../constant/pixel_ratio.dart';
import '../model/ad_helper.dart';

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
  int cardColorCode = 0;
  final _formKey = GlobalKey<FormBuilderState>();
  late List<DropdownMenuItem<String>> numberList = [];
  late bool _isLoading = false;
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;
  InterstitialAd? _interstitialAd;
  late int _interstitialLoadAttempts = 0;

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts ++;
          _interstitialAd = null;
          if( _interstitialLoadAttempts <= 3){
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }

  getNumberList(){
    for(var i=20; i<200; i++){
    setState(() {
      numberList.add(DropdownMenuItem(
        alignment: AlignmentDirectional.centerStart,
        value: '$i',
        child: Text('$i'),
      ));
    });
    }
  }

  int changeFootToInc() {
    int height;
    int heightInFootToInc = (heightInFoot * 12);
    height = (heightInFootToInc + heightInInch);
    return height;
  }

  @override
  void initState() {
    getNumberList();
    _createBottomBannerAd();
    _createInterstitialAd();
    super.initState();
  }

  @override
  void dispose() {
    _bottomBannerAd.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        onChanged: () {
      _formKey.currentState!.save();
    },child: CustomOrientationBuilder(
        portrait: Scaffold(
          appBar: const CustomAppBar(title: 'BMI Meter',),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widthRatio / thirtyTwoPixelRatioW),
            child: SingleChildScrollView(
               child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildGenderRowPortrait(context),
                  _buildSliderPortrait(context),
                  _buildWeightRowPortrait(context),
                  PrimaryButtonPortrait(
                    buttonTitle: 'Calculate',
                    onTap: () {

                      try {
                        if (_formKey.currentState?.saveAndValidate() ??
                            false) {

                          setState(() {
                            _isLoading = true;
                          });

                          BMICalculator calc = BMICalculator(
                              height: changeFootToInc(), weight: int.parse(_formKey.currentState?.value['weight']));

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return ResultScreen(
                                  bmiResult: calc.calculateBMI(),
                                  resultText: calc.getResult(),
                                  interpretation: calc.getInterpretation(),
                                );
                              }));

                        }else{
                          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                            content: Text('Please enter you weight to get your BMI result!'),
                          ));
                        }
                        _showInterstitialAd();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                        content: Text(e.toString()),
                      ));
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: heightRatio / sixteenPixelRatioH,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: _isBottomBannerAdLoaded
              ? Container(
            height: _bottomBannerAd.size.height.toDouble(),
            width: double.infinity,
            child: AdWidget(ad: _bottomBannerAd),
          )
              : null,
        ),
        landscape: Scaffold(
          appBar: const CustomAppBar(title: 'BMI Meter',),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widthRatio / thirtyTwoPixelRatioW),
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
                      try {
                        if (_formKey.currentState?.saveAndValidate() ??
                            false) {

                          setState(() {
                            _isLoading = true;
                          });

                          BMICalculator calc = BMICalculator(
                              height: changeFootToInc(), weight: int.parse(_formKey.currentState?.value['weight']));

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return ResultScreen(
                                  bmiResult: calc.calculateBMI(),
                                  resultText: calc.getResult(),
                                  interpretation: calc.getInterpretation(),
                                );
                              }));

                        }else{
                          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                            content: Text('Please enter you weight to get your BMI result!'),
                          ));
                        }
                        _showInterstitialAd();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                          content: Text(e.toString()),
                        ));
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: widthRatio / sixteenPixelRatioH * 2,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: _isBottomBannerAdLoaded
              ? Container(
            height: _bottomBannerAd.size.height.toDouble(),
            width: double.infinity,
            child: AdWidget(ad: _bottomBannerAd),
          )
              : null,
        )));
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

    return CustomCard( cardHeight: heightRatio / oneNinetyPixelRatioH,
        cardChild: Column(
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
                    thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 20),
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
                              fontSize: heightRatio / twentyPixelRatioH  ,
                              color: white,
                              fontWeight: FontWeight.w700)),
                    ),
                    Text(
                      ' Foot',
                      style: TextStyle(
                          fontSize: heightRatio / sixteenPixelRatioH ,
                          color: ass,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ],
            ),
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
                    thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 20),
                  ),
                  child: Slider(
                      value: heightInInch.toDouble(),
                      min: 0.0,
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
                              fontSize: heightRatio / twentyPixelRatioH ,
                              color: white,
                              fontWeight: FontWeight.w700)),
                    ),
                    Text(
                      ' Inch',
                      style: TextStyle(
                          fontSize: heightRatio / sixteenPixelRatioH ,
                          color: ass,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ));
  }

  Widget _buildSliderLandscape(BuildContext context) {
    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;
    return CustomCard( cardHeight: widthRatio / oneNinetyPixelRatioH * 2,
      cardChild: Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Text(
      'Height',
      style: GoogleFonts.roboto(
          textStyle: TextStyle(
              fontSize: widthRatio / twentyFivePixelRatioH * 2,
              color: ass)),
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
              thumbShape:
              const RoundSliderThumbShape(enabledThumbRadius: 10),
              overlayShape:
              const RoundSliderOverlayShape(overlayRadius: 20),
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
                        fontSize: widthRatio / twentyPixelRatioH * 2,
                        color: white,
                        fontWeight: FontWeight.w700)),
              ),
              Text(
                ' Foot',
                style: TextStyle(
                    fontSize: widthRatio / sixteenPixelRatioH * 2,
                    color: ass,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ],
      ),
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
              thumbShape:
              const RoundSliderThumbShape(enabledThumbRadius: 10),
              overlayShape:
              const RoundSliderOverlayShape(overlayRadius: 20),
            ),
            child: Slider(
                value: heightInInch.toDouble(),
                min: 0.0,
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
                        fontSize: widthRatio / twentyPixelRatioH * 2,
                        color: white,
                        fontWeight: FontWeight.w700)),
              ),
              Text(
                ' Inch',
                style: TextStyle(
                    fontSize: widthRatio / sixteenPixelRatioH * 2,
                    color: ass),
              ),
            ],
          ),
        ],
      ),
    ),
  ],
),);
  }

  Widget _buildWeightRowPortrait(BuildContext context) {
    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return  Padding(
      padding: EdgeInsets.symmetric(vertical: heightRatio / thirtyTwoPixelRatioH),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weight',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: heightRatio / twentyFivePixelRatioH,
                      color: ass,
                      fontWeight: FontWeight.w700),
                ),
              ),
               const SizedBox(height: 8,),
                SizedBox(
                width: widthRatio / 2.6,
                child: FormBuilderDropdown<String>(
                  style: const TextStyle(color: ass,fontSize: 20),
                  dropdownColor: activeCardColor,
                  iconEnabledColor: ass,
                  name: 'weight',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: inactiveCardColor,
                    contentPadding: EdgeInsets.all(16),
                    hintText: 'Weight',
                    hintStyle: const TextStyle(color: ass,fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusColor: white,
                  ),
                  items: numberList,
                  valueTransformer: (val) => val?.toString(),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Age',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: heightRatio / twentyFivePixelRatioH,
                      color: ass,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 8,),
              SizedBox(
                width: widthRatio / 2.6,
                child: FormBuilderDropdown<String>(
                  style: const TextStyle(color: ass,fontSize: 20),
                  dropdownColor: activeCardColor,
                  iconEnabledColor: ass,
                  name: 'age',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: inactiveCardColor,
                    contentPadding: const EdgeInsets.all(16),
                    hintText: 'Age',
                    hintStyle: const TextStyle(color: ass,fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusColor: white,
                  ),
                  items: numberList,
                  valueTransformer: (val) => val?.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeightRowLandscape(BuildContext context) {
    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: widthRatio / thirtyTwoPixelRatioH * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weight',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: widthRatio / twentyFivePixelRatioH * 2,
                      color: ass,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                width: widthRatio / 2.6,
                child: FormBuilderDropdown<String>(
                  style: const TextStyle(color: ass,fontSize: 20),
                  dropdownColor: activeCardColor,
                  iconEnabledColor: ass,
                  name: 'weight',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: inactiveCardColor,
                    contentPadding: EdgeInsets.all(16),
                    hintText: 'Weight',
                    hintStyle: const TextStyle(color: ass,fontSize: 20),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusColor: white,
                  ),
                  items: numberList,
                  valueTransformer: (val) => val?.toString(),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Age',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: widthRatio / twentyFivePixelRatioH * 2,
                      color: ass,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                width: widthRatio / 2.6,
                child: FormBuilderDropdown<String>(
                  style: const TextStyle(color: ass,fontSize: 20),
                  dropdownColor: activeCardColor,
                  iconEnabledColor: ass,
                  name: 'age',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: inactiveCardColor,
                    contentPadding: EdgeInsets.all(16),
                    hintText: 'Age',
                    hintStyle: const TextStyle(color: ass,fontSize: 20),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusColor: white,
                  ),
                  items: numberList,
                  valueTransformer: (val) => val?.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
