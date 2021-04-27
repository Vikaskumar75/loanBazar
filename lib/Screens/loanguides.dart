import 'package:flutter/material.dart';

import '../Screens/about.dart';
import '../Screens/category.dart';
import '../Screens/home.dart';

class LoanGuides extends StatefulWidget {
  @override
  _LoanGuidesState createState() => _LoanGuidesState();
}

class _LoanGuidesState extends State<LoanGuides> with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: TabBarView(
            controller: _tabController,
            children: [
              Category(),
              Home(),
              About(),
            ],
          ),
          bottomSheet: SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                indicatorWeight: 8,
                indicatorColor: Theme.of(context).primaryColor,
                physics: BouncingScrollPhysics(),
                tabs: [
                  _customTabBarWidget(context, icon: Icons.menu, label: 'Categories'),
                  _customTabBarWidget(context, icon: Icons.account_balance_outlined, label: 'Loans'),
                  _customTabBarWidget(context, icon: Icons.info, label: 'About'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTabBarWidget(BuildContext context, {IconData icon, String label}) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        Text(
          label,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
