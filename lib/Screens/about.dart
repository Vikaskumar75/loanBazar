import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

import '../Components/constants.dart';
import '../Components/facebookAds.dart';
import '../Components/utilities.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final MyFacebookAdsManager adsManager = MyFacebookAdsManager();

  loadAd() async {
    await adsManager.showInterstitialAd();
  }

  @override
  void initState() {
    super.initState();
    FacebookAudienceNetwork.init(testingId: "55afa8d9-ff1d-4271-b46a-7f877515e355");
    adsManager.loadInterstitialAd();
    loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'About',
            style: kAppBarStyle,
          ),
        ),
        body: ListView.builder(
          itemCount: legalInfo.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: adsManager.showBannerAd(),
                  ),
                ),
                Container(
                  decoration: kAboutBoxDecoration,
                  child: Collapsible(
                    header: legalInfo[index].headerValue,
                    info: legalInfo[index].bodyValue,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
