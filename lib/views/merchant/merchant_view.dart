import 'package:flutter/material.dart';

import 'widget/merchant_table.dart';

class MerchantTableView extends StatefulWidget {
  MerchantTableView({Key? key}) : super(key: key);

  @override
  _MerchantTableViewState createState() => _MerchantTableViewState();
}

class _MerchantTableViewState extends State<MerchantTableView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> options = [
    'All Vendors',
    'Active',
    'Pending',
    'Top Picked',
    'Top Rated',
    'Big Earners',
    'Low rated',
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // const SizedBox(
          //   height: 20,
          // ),
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
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 60),
              indicatorColor: Colors.red,
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
                  .map((title) => MerchantTable(
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
