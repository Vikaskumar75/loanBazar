import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Components/constants.dart';
import '../Components/facebookAds.dart';

class UserDisplay extends StatefulWidget {
  final DocumentSnapshot docToDisplay;

  UserDisplay({this.docToDisplay});

  @override
  _UserDisplayState createState() => _UserDisplayState();
}

class _UserDisplayState extends State<UserDisplay> {
  final MyFacebookAdsManager adsManager = MyFacebookAdsManager();

  bool isLoading = true;
  timer() {
    adsManager.showInterstitialAd();
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    FacebookAudienceNetwork.init();
    adsManager.loadInterstitialAd();
    timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.docToDisplay.data()['AppName']),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share(widget.docToDisplay.data()['AppLink']);
                  }),
            )
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              )
            : Padding(
                padding: EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: adsManager.showBannerAd(),
                      ),
                    ),
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        child: Image.network(
                          widget.docToDisplay.data()['ImageUrl'],
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: adsManager.showBannerAd(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        widget.docToDisplay.data()['AppDescription'],
                        style: kUserDisplayDescription,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.2),
                      child: Container(
                        child: adsManager.showBannerAd(),
                      ),
                    ),
                  ],
                ),
              ),
        bottomSheet: SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: adsManager.showBannerAd(),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Apply Now'),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                  onPressed: () async {
                    adsManager.showInterstitialAd();
                    var _url = widget.docToDisplay.data()['AppLink'];
                    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
                  },
                  // onPress: () async {
                  //   await launch(widget.docToDisplay.data()['AppLink']);
                  // },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
