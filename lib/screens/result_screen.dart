import 'package:body_mass_index/common/custom_card.dart';
import 'package:body_mass_index/common/custom_orientation_builder.dart';
import 'package:body_mass_index/common/primary_button.dart';
import 'package:body_mass_index/constant/color.dart';
import 'package:body_mass_index/constant/pixel_ratio.dart';
import 'package:body_mass_index/screens/expert_suggesions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../common/custom_appbar.dart';
import '../model/ad_helper.dart';

class ResultScreen extends StatefulWidget {
  final String? bmiResult;
  final String? resultText;
  final String? interpretation;

  const ResultScreen({this.bmiResult, this.resultText, this.interpretation});

  static const String name = 'Input_screen';

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  final String underWeightConsultancy =
      'https://www.healthline.com/nutrition/how-to-gain-weight';
  final String overWeightConsultancy =
      'https://www.medicalnewstoday.com/articles/322345#science-backed-ways-to-lose-weight';
  final String normalWeightConsultancy =
      'https://reverehealth.com/live-better/tips-to-maintain-a-healthy-weight/';

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
      adUnitId: AdHelper.interstitialTwoAdUnitId,
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

  @override
  void initState() {
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

    return CustomOrientationBuilder(
        portrait: Scaffold(
          appBar: const CustomAppBar(title: 'Result',),
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widthRatio / thirtyTwoPixelRatioW,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildResultBodyPortrait(context),
                    SizedBox(
                      height: heightRatio / sixteenPixelRatioH,
                    ),
                    PrimaryButtonPortrait(
                        buttonTitle: 'Consultancy',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExpertSuggestion(
                                        consultantUrl:
                                            widget.resultText == 'Normal'
                                                ? normalWeightConsultancy
                                                : widget.resultText ==
                                                        'Over Weight'
                                                    ? overWeightConsultancy
                                                    : underWeightConsultancy,
                                      )));
                        }),
                    SizedBox(
                      height: heightRatio / sixteenPixelRatioH,
                    ),
                    PrimaryButtonPortrait(
                        buttonTitle: 'Re-Calculate',
                        onTap: () {
                          Navigator.pop(context);
                          _showInterstitialAd();
                        }),
                  ],
                ),
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
          appBar: const CustomAppBar(title: 'Result',),
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: widthRatio / thirtyTwoPixelRatioW),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildResultBodyLandscape(context),
                    SizedBox(
                      height: widthRatio / sixteenPixelRatioH * 2,
                    ),
                    PrimaryButtonLandscape(
                        buttonTitle: 'Consultancy',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExpertSuggestion(
                                    consultantUrl:
                                    widget.resultText == 'Normal'
                                        ? normalWeightConsultancy
                                        : widget.resultText ==
                                        'Over Weight'
                                        ? overWeightConsultancy
                                        : underWeightConsultancy,
                                  )));
                        }),
                    SizedBox(
                      height: widthRatio / sixteenPixelRatioH * 2,
                    ),
                    PrimaryButtonLandscape(
                        buttonTitle: 'Re-Calculate',
                        onTap: () {
                          Navigator.pop(context);
                          _showInterstitialAd();
                        }),
                  ],
                ),
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
        ));
  }

  Widget _buildResultBodyPortrait(BuildContext context) {

    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return CustomCard(
      cardHeight: heightRatio / fiveHundredPixelRatioH,
      cardChild: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.resultText!,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: heightRatio / thirtyFivePixelRatioH,
                    color: widget.resultText == 'Normal' ? green : buttonColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              widget.bmiResult!,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: heightRatio / eightyPixelRatioH,
                    color: white,
                    fontWeight: FontWeight.w700),
              ),
            ),
            RichText(
              text: TextSpan(
                text: widget.interpretation!,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: heightRatio / twentyPixelRatioH,
                      color: white,
                      fontWeight: FontWeight.w400),
                ),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          ' Click the consultancy button to get expert opinion.',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: heightRatio / twentyPixelRatioH,
                            color: ass,
                            fontWeight: FontWeight.w400),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultBodyLandscape(BuildContext context) {
    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return CustomCard(
      cardHeight: widthRatio / fiveHundredPixelRatioH * 2,
      cardChild: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.resultText!,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: widthRatio / thirtyFivePixelRatioH * 2,
                    color: widget.resultText == 'Normal' ? green : buttonColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              widget.bmiResult!,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: widthRatio / eightyPixelRatioH * 2,
                    color: white,
                    fontWeight: FontWeight.w700),
              ),
            ),
            RichText(
              text: TextSpan(
                text: widget.interpretation!,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: widthRatio / twentyPixelRatioH * 2,
                      color: white,
                      fontWeight: FontWeight.w400),
                ),
                children: <TextSpan>[
                  TextSpan(
                      text:
                      ' Click the consultancy button to get expert opinion.',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: widthRatio / twentyPixelRatioH * 2,
                            color: ass,
                            fontWeight: FontWeight.w400),
                      )),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

}
