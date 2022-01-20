import 'package:flutter/material.dart';
import 'package:godartadmin/utils/auth_utils.dart';

import 'package:godartadmin/views/category/category_view.dart';

import 'package:godartadmin/views/drivers/driver_view.dart';
import 'package:godartadmin/views/home_view.dart';
import 'package:godartadmin/views/merchant/merchant_view.dart';

import 'package:godartadmin/views/overview/over_view_desktop.dart';
import 'package:godartadmin/views/support/support_view.dart';

import 'route_names.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewRoute:
      return _getPageRoute(const OverViewPage());
    case driversRoute:
      return _getPageRoute(const DriverTableView());
    case merchantsRoute:
      return _getPageRoute(MerchantTableView());
    case supportRoute:
      return _getPageRoute(const SupportView());
    case categoryRoute:
      return _getPageRoute(const CategoryView());
    case homeRoute:
      return _getPageRoute(const HomeView());
    case authRoute:
      return _getPageRoute(AuthView());
    default:
      return _getPageRoute(const Undefined());
  }
}

PageRoute _getPageRoute(Widget child) {
  return _FadeRoute(child: child);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  _FadeRoute({required this.child})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

class Undefined extends StatelessWidget {
  const Undefined({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Text(
            '404',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
          ),
          Text(
            'Page Not Found',
            style: TextStyle(
              fontSize: 30,
            ),
          )
        ],
      ))),
    );
  }
}
