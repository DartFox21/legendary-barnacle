import 'package:flutter/material.dart';
import 'package:godartadmin/locator.dart';
import 'package:godartadmin/routing/route_names.dart';
import 'package:godartadmin/routing/router.dart';
import 'package:godartadmin/services/navigation_service.dart';
import 'package:godartadmin/widgets/navigation_bar.dart';

class HomeViewMPortrait extends StatelessWidget {
  HomeViewMPortrait({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const NavBar(),
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
