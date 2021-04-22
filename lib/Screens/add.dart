import 'package:loanguides/Components/constants.dart';
import 'package:loanguides/Components/firebase.dart';
import 'package:loanguides/Components/utilities.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  final fireStore = FireStore();
  final fireStorage = FireStorage();

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController _appName = TextEditingController();
  TextEditingController _appDescription = TextEditingController();
  TextEditingController _appLink = TextEditingController();

  String dropDownValue;
  var file;
  var imageUrl;

  @override
  void dispose() {
    _appName.dispose();
    _appLink.dispose();
    _appDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Loan Guides'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Cover Image Container
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    file == null
                        ? Container(
                            height: 200,
                            decoration: kCoverImageDecorator,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera),
                                  Text('Cover Image')
                                ],
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            child: Image(
                              image: FileImage(file),
                              fit: BoxFit.contain,
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 4),
                      child: RaisedButton(
                        onPressed: () async {
                          var path = await uploadImage();
                          if (path != null) {
                            print(path);
                            setState(() {
                              file = path;
                            });
                          }
                        },
                        padding: EdgeInsets.all(4.0),
                        color: Theme.of(context).primaryColor,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0))),
                        child: Text(
                          'Upload',
                          style: kButtonTextStyle.copyWith(fontSize: 14.0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                //AppName
                Text('App Name *', style: kTextFieldTitle),
                SizedBox(
                  height: 6.0,
                ),
                TextField(
                  controller: _appName,
                  decoration: inputDecorator.copyWith(hintText: 'App Name'),
                ),
                SizedBox(
                  height: 15.0,
                ),
                //App Quality
                Text('App Category *', style: kTextFieldTitle),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: dropDownValue == null
                            ? Colors.grey[400]
                            : Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 4, 4, 4),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropDownValue,
                        dropdownColor: Theme.of(context).accentColor,
                        elevation: 10,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36.0,
                        iconEnabledColor: Theme.of(context).primaryColor,
                        hint: Text('Select Category', style: kDropDownHint),
                        style: kDropDownList,
                        onChanged: (String newValue) {
                          setState(() {
                            dropDownValue = newValue;
                          });
                        },
                        items:
                            item.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                //App Description
                Text(
                  'App Description *',
                  style: kTextFieldTitle,
                ),
                SizedBox(
                  height: 6.0,
                ),
                TextField(
                  controller: _appDescription,
                  decoration:
                      inputDecorator.copyWith(hintText: 'App Description'),
                  maxLines: 15,
                ),
                SizedBox(
                  height: 10.0,
                ),
                //App Link
                Text(
                  'App Link *',
                  style: kTextFieldTitle,
                ),
                SizedBox(
                  height: 6.0,
                ),
                TextField(
                  controller: _appLink,
                  decoration: inputDecorator.copyWith(
                      hintText: 'App link', suffixIcon: Icon(Icons.link)),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: double.infinity,
                  child: Builder(
                    builder: (context) => Button(
                        text: 'SUBMIT',
                        color: Theme.of(context).primaryColor,
                        onPress: () async {
                          if (_appName.text == "" ||
                              _appDescription.text == "" ||
                              _appLink.text == "" ||
                              dropDownValue == null) {
                            Scaffold.of(context).showSnackBar(
                              snackBar,
                            );
                          } else {
                            var downloadUrl = await widget.fireStorage
                                .addImage(file, _appName.text);
                            imageUrl = downloadUrl;
                            await widget.fireStore
                                .addApp(
                                    _appName.text,
                                    dropDownValue,
                                    _appDescription.text,
                                    _appLink.text,
                                    imageUrl.toString())
                                .whenComplete(
                                  () => Navigator.pop(context),
                                );
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
