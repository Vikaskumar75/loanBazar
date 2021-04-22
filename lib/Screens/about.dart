import 'package:flutter/material.dart';
import 'package:loanguides/Components/constants.dart';
import 'package:loanguides/Components/utilities.dart';

class About extends StatelessWidget {
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
              itemBuilder: (context,index){
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: kAboutBoxDecoration,
                        child: Collapsible(
                          header: legalInfo[index].headerValue,
                          info: legalInfo[index].bodyValue,
                        ),
                      ),
                    ),
                  ],
                );
              })
      ),
    );
  }
}
