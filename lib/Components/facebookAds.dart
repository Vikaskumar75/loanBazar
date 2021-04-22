import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:loanguides/Components/constants.dart';


class MyFacebookAdsManager {
  bool _isInterstitialAdLoaded = false;

  void loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId:kInterstitialAdId,
      listener: (result, value) {
        print("Interstitial Ad: $result -->  $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          loadInterstitialAd();
        }
      },
    );
  }
  void showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else
      loadInterstitialAd();
  }

  Widget currentAd = SizedBox(
    width: 200.0,
    height: 20.0,
  );


  Widget showBannerAd(){
    currentAd = FacebookBannerAd(
      placementId: kBannerAdId,
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        print("Banner Ad: $result -->  $value");
      },
    );
    return currentAd;
  }
}