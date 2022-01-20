import 'package:flutter/material.dart';
import 'package:godartadmin/routing/route_names.dart';
import 'package:godartadmin/routing/router.dart';
import 'package:godartadmin/services/navigation_service.dart';
import 'package:godartadmin/widgets/navigation_bar.dart';

import '../../locator.dart';

class HomeViewTablet extends StatelessWidget {
  const HomeViewTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          const NavBar(),
          Expanded(
              child: Column(
            children: [
              Container(
                color: Colors.red,
                height: 60,
              ),
              Expanded(
                  child: Navigator(
                key: locator<NavigationService>().navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: overviewRoute,
              )),
            ],
          )),
        ],
      )),
    );
  }
}
