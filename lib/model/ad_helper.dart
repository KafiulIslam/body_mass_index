import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      //String realAdUnitId = "ca-app-pub-6871786334119508/9798532613";
      String testAdUnitId = "ca-app-pub-3940256099942544/6300978111";
      return testAdUnitId;
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      //String realInterstitialAdUnit = "ca-app-pub-6871786334119508/4391127411";
      String defaultInterstitialAdUnit = "ca-app-pub-3940256099942544/8691691433";
      return defaultInterstitialAdUnit;
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/5135589807";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialTwoAdUnitId {
    if (Platform.isAndroid) {
      //String realInterstitialAdUnit = "ca-app-pub-6871786334119508/9393589306";
      String defaultInterstitialAdUnit = "ca-app-pub-3940256099942544/8691691433";
      return defaultInterstitialAdUnit;
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/5135589807";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

}