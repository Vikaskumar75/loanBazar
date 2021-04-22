import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loanguides/Components/constants.dart';
import 'package:loanguides/Components/facebookAds.dart';
import 'package:loanguides/Components/utilities.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDisplay extends StatefulWidget {
  final DocumentSnapshot docToDisplay;

  UserDisplay({Key key, this.docToDisplay}) : super(key: key);

  @override
  _UserDisplayState createState() => _UserDisplayState();
}

class _UserDisplayState extends State<UserDisplay> {
  final MyFacebookAdsManager adsManager = MyFacebookAdsManager();

  @override
  void initState() {
    FacebookAudienceNetwork.init(
    );
    adsManager.loadInterstitialAd(

    );
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
                  onPressed: () async {
                    await share(widget.docToDisplay);
                  }),
            )
          ],
        ),
        body: Padding(
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
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  widget.docToDisplay.data()['AppDescription'],
                  style: kUserDisplayDescription,
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Button(
              text: 'APPLY NOW',
              color: Theme.of(context).primaryColor,
              onPress: () async {
                await launch(widget.docToDisplay.data()['AppLink']);
              },
            ),
          ),
        ),
      ),
    );
  }
}
