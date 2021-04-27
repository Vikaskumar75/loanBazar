import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

class MyFacebookAdsManager {
  bool _isInterstitialAdLoaded = false;

  Future<void> loadInterstitialAd() async {
    await FacebookInterstitialAd.loadInterstitialAd(
      // placementId: kInterstitialAdId,
      listener: (result, value) {
        print("Interstitial Ad: $result -->  $value");
        if (result == InterstitialAdResult.LOADED) _isInterstitialAdLoaded = true;
        if (result == InterstitialAdResult.DISMISSED && value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          loadInterstitialAd();
        }
      },
    );
  }

  Future<void> showInterstitialAd() async {
    if (_isInterstitialAdLoaded == true)
      await FacebookInterstitialAd.showInterstitialAd();
    else
      await loadInterstitialAd();
  }

  Widget currentAd = SizedBox(
    width: 200.0,
    height: 20.0,
  );

  Widget showBannerAd() {
    currentAd = FacebookBannerAd(
      // placementId: kBannerAdId,
      bannerSize: BannerSize.STANDARD,
      keepAlive: true,
      listener: (result, value) {
        print("Banner Ad: $result -->  $value");
      },
    );
    return currentAd;
  }
}
