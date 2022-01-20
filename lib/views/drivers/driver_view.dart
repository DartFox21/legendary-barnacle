import 'package:flutter/material.dart';

import 'widget/table_widget.dart';

class DriverTableView extends StatefulWidget {
  const DriverTableView({Key? key}) : super(key: key);

  @override
  State<DriverTableView> createState() => _DriverTableViewState();
}

class _DriverTableViewState extends State<DriverTableView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: options.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<String> options = [
    'All Drivers',
    'Active',
    'Pending',
    'deactivated',
    'Top Rated',
    'Big Earners',
    'Low rated',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]
          Container(
            padding: const EdgeInsets.all(2),
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                4.0,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicatorColor: Colors.red,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 60),
              labelColor: Colors.red,
              unselectedLabelColor: Colors.black,
              tabs: options
                  .map((title) => Tab(
                        text: title,
                      ))
                  .toList(),
            ),
          ),

          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: options
                  .map((title) => DriverTable(
                        title: title,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
