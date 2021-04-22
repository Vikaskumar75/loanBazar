import 'package:loanguides/Screens/filtered.dart';
import 'package:flutter/material.dart';
import 'package:loanguides/Components/constants.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
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
        body: ListView.builder(
            itemCount: item.length,
            itemBuilder: (context, _index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Filtered(
                            filterData: item[_index],
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
              );
            }),
      ),
    );
  }
}
