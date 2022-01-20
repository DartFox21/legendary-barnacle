import 'package:flutter/material.dart';

import 'widgets/data_tables.dart';
import 'widgets/large_screen_cards.dart';

import 'widgets/revenue_data_lg.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: const [
              SizedBox(
                height: 20,
              ),
              LargeCards(),
              RevenueDataLarge(),
              RecentOrdersTable(),
            ],
          ),
        ),
      ],
    );
  }
}
