import 'package:loanguides/Screens/about.dart';
import 'package:loanguides/Screens/category.dart';
import 'package:loanguides/Screens/home.dart';
import 'package:flutter/material.dart';

class LoanGuides extends StatefulWidget {
  @override
  _LoanGuidesState createState() => _LoanGuidesState();
}

class _LoanGuidesState extends State<LoanGuides> {
  PageController _pageController = PageController();

  List<Widget> _screens = [
    Home(),
    Category(),
    About(),
  ];

  int _selectedIndex = 0;

  void _onPageChanged(int currentIndex) {
    setState(() {
      _selectedIndex = currentIndex;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.info,
              ),
              label: 'About',
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
