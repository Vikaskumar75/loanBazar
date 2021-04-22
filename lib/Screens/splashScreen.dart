import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loanguides/Screens/loanguides.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progressValue = 0;

  void _updateProgress() {
    const oneSec = Duration(milliseconds: 29);
    Timer.periodic(oneSec, (Timer t) {
      _progressValue += 0.012;

      if (_progressValue.toStringAsFixed(1) == '1') {
        t.cancel();
        setState(() {
          _progressValue = 0.0;
        });
        return;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _updateProgress();
    Timer(Duration(seconds: 3), () {
      return Navigator.pushReplacement(
        context,
        // ignore: missing_return
        MaterialPageRoute(builder: (context) {
          return LoanGuides();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/images/playstore.png'),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Loan Guides',
                      style:
                          TextStyle(color: Theme.of(context).primaryColor, fontSize: 30.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: LinearProgressIndicator(
                        value: _progressValue,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
