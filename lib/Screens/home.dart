import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:loanguides/Components/constants.dart';
import 'package:loanguides/Components/facebookAds.dart';
import 'package:loanguides/Components/utilities.dart';
import '../Screens/add.dart';
import '../Screens/edit.dart';
import 'package:loanguides/Screens/userDisplay.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference app = FirebaseFirestore.instance.collection('Apps');
  final MyFacebookAdsManager adsManager = MyFacebookAdsManager();

  @override
  void initState() {
    super.initState();
    FacebookAudienceNetwork.init(
    );
    adsManager.loadInterstitialAd();
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
            'Loan Guide',
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
                return Padding(
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
                                  Image(
                                    image:NetworkImage(
                                        document.data()['ImageUrl']),
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
                                        Builder(
                                            builder: (BuildContext context) {
                                          return IconButton(
                                              icon: Icon(
                                                Icons.share,
                                                color:
                                                    Theme.of(context).cardColor,
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
                              padding: EdgeInsets.only(left:10.0,right: 10.0,top: 10.0),
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
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.8,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
