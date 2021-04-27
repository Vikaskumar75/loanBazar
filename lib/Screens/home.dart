import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../Components/constants.dart';
import '../Components/facebookAds.dart';
import '../Screens/userDisplay.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference app = FirebaseFirestore.instance.collection('Apps');
  final MyFacebookAdsManager adsManager = MyFacebookAdsManager();
  bool isLoading = true;
  timer() async {
    await adsManager.showInterstitialAd();
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    FacebookAudienceNetwork.init(testingId: "55afa8d9-ff1d-4271-b46a-7f877515e355");
    adsManager.loadInterstitialAd();

    timer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/playstore.png'),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Loan Bazzar',
            style: kAppBarStyle,
          ),

          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: 8.0),
          //     child: IconButton(
          //       icon: Icon(Icons.add),
          //       onPressed: () {
          //         Navigator.push(
          //             context, MaterialPageRoute(builder: (_) => Add()));
          //       },
          //     ),
          //   )
          // ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              )
            : StreamBuilder<QuerySnapshot>(
                stream: app.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
                    child: ListView(
                      children: snapshot.data.docs.map((DocumentSnapshot snapshot) {
                        return GestureDetector(
                          onTap: () async {
                            await adsManager.showInterstitialAd().then(
                                  (value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => UserDisplay(
                                        docToDisplay: snapshot,
                                      ),
                                    ),
                                  ),
                                );
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: adsManager.showBannerAd(),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Card(
                                  margin: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.12,
                                        child: Image.network(
                                          snapshot.data()['ImageUrl'],
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot.data()['AppName'],
                                                  style: kCardAppName,
                                                  textAlign: TextAlign.start,
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.share),
                                                  onPressed: () {
                                                    Share.share(snapshot.data()['AppLink']);
                                                  },
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              snapshot.data()['AppDescription'],
                                              style: kCardDescription,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await adsManager.showInterstitialAd().then(
                                          (value) => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => UserDisplay(
                                                docToDisplay: snapshot,
                                              ),
                                            ),
                                          ),
                                        );
                                  },
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(0.8))),
                                  child: Text('Apply Now'),
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
