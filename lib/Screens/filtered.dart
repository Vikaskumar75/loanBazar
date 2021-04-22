import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import '../Screens/edit.dart';
import 'package:loanguides/Components/constants.dart';
import 'package:loanguides/Components/facebookAds.dart';
import 'package:loanguides/Components/utilities.dart';
import 'package:loanguides/Screens/userDisplay.dart';

class Filtered extends StatefulWidget {
  final String filterData;

  Filtered({this.filterData});

  @override
  _FilteredState createState() => _FilteredState();
}

class _FilteredState extends State<Filtered> {
  CollectionReference app = FirebaseFirestore.instance.collection('Apps');
  final MyFacebookAdsManager adsManager = MyFacebookAdsManager();

  @override
  void initState() {
    FacebookAudienceNetwork.init(
    );
    adsManager.loadInterstitialAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.filterData + ' Apps'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: app.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return document.data()['AppCategory'] == widget.filterData
                    ? Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: adsManager.showBannerAd(),
                              ),
                            ),
                            Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      adsManager.showInterstitialAd();
                                      Future.delayed(Duration(seconds: 5));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => UserDisplay(
                                            docToDisplay: document,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        Image.network(
                                          document.data()['ImageUrl'],
                                          height: 160,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                document.data()['AppName'],
                                                style: kCardAppName,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Builder(builder:
                                                  (BuildContext context) {
                                                return IconButton(
                                                    icon: Icon(
                                                      Icons.share,
                                                      color: Theme.of(context)
                                                          .cardColor,
                                                    ),
                                                    onPressed: () async {
                                                      await share(document);
                                                    });
                                              })
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      document.data()['AppDescription'],
                                      style: kCardDescription,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          // CardButton(
                                          //   text: 'Edit Info',
                                          //   onPress: () {
                                          //     Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(
                                          //         builder: (context) => Edit(
                                          //           docToEdit: document,
                                          //         ),
                                          //       ),
                                          //     );
                                          //   },
                                          // ),
                                          SizedBox(
                                            width: 14,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: CardButton(
                                              text: 'Apply Now',
                                              onPress: () {
                                                adsManager.showInterstitialAd();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => UserDisplay(
                                                      docToDisplay: document,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink();
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
