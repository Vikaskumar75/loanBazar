import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';

import 'constants.dart';

class Button extends StatelessWidget {
  Button({this.text, this.onPress, this.color});
  final String text;
  final Function onPress;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPress(),
      padding: EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(36.0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 10.0,
      color: color,
      hoverColor: Theme.of(context).accentColor,
      child: Text(
        text,
        style: kButtonTextStyle,
      ),
    );
  }
}

InputDecoration inputDecorator = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 12.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
    borderSide: BorderSide(
      color: (Colors.cyan[600]),
      style: BorderStyle.solid,
    ),
  ),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
      borderSide: BorderSide(
        color: (Colors.grey[400]),
      )),
);

final SnackBar snackBar = SnackBar(
  content: Text(
    'Please Fill All The Fields',
    style: TextStyle(
      color: Colors.white,
    ),
  ),
  duration: Duration(seconds: 3),
  backgroundColor: Colors.red,
);

uploadImage() async {
  List<Media> res = await ImagesPicker.pick(count: 1, pickType: PickType.image, cropOpt: CropOption(aspectRatio: CropAspectRatio.wh2x1));
  if (res != null) {
    print(res.map((e) => e.path).toList());
    var file = File(res[0].path);
    return file;
  } else
    return null;
}

class CardButton extends StatelessWidget {
  final String text;
  final Function onPress;

  const CardButton({this.text, this.onPress});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPress(),
      child: Text(
        text,
        style: kCardButtonTextStyle,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Theme.of(context).primaryColor,
      hoverColor: Colors.grey,
    );
  }
}

class AlertDelete extends StatelessWidget {
  final String appName;
  final Function onPress1;
  final Function onPress2;

  const AlertDelete({this.appName, this.onPress1, this.onPress2});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete ' + appName,
        style: kAlertDeleteTextStyle,
      ),
      contentPadding: EdgeInsets.all(10.0),
      content: Padding(
        padding: EdgeInsets.only(left: 14.0),
        child: Text('Are You Sure ?'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      actions: [
        TextButton(
          onPressed: onPress1(),
          child: Text(
            'Delete',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        TextButton(
          onPressed: onPress2(),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class Collapsible extends StatelessWidget {
  const Collapsible({this.header, this.info});
  final String header;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6.0, 3, 6, 3),
      child: ExpandableTheme(
        data: ExpandableThemeData(iconColor: Color(0xFF0B295D), headerAlignment: ExpandablePanelHeaderAlignment.center),
        child: ExpandablePanel(
          header: Text(
            header,
            style: kCollapsibleHeaderStyle,
          ),
          expanded: Padding(
            padding: EdgeInsets.only(top: 2.0, bottom: 5.0),
            child: Text(
              info,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
          collapsed: null,
        ),
      ),
    );
  }
}
