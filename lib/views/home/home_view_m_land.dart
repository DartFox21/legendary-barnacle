import 'package:flutter/material.dart';
import 'package:godartadmin/locator.dart';
import 'package:godartadmin/routing/route_names.dart';
import 'package:godartadmin/routing/router.dart';
import 'package:godartadmin/services/navigation_service.dart';
import 'package:godartadmin/widgets/navigation_bar.dart';

class HomeViewMLandscape extends StatelessWidget {
  const HomeViewMLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          const NavBar(),
          Expanded(
              child: Navigator(
            key: locator<NavigationService>().navigatorKey,
            onGenerateRoute: generateRoute,
            initialRoute: overviewRoute,
          )),
        ],
      ),
    );
  }
}
