import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

import '../Components/constants.dart';
import '../Components/facebookAds.dart';
import '../Screens/filtered.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
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
          centerTitle: true,
          title: Text(
            'Categories',
            style: kAppBarStyle,
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              )
            : ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, _index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: adsManager.showBannerAd(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.09,
                            child: Center(
                              child: ListTile(
                                onTap: () async {
                                  await adsManager.showInterstitialAd().then(
                                        (value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => Filtered(
                                              filterData: item[_index],
                                            ),
                                          ),
                                        ),
                                      );
                                },
                                leading: leadingIcon[_index],
                                title: Text(item[_index], style: kCategoryCardStyle),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
      ),
    );
  }
}
