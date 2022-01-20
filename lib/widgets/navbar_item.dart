import 'package:flutter/material.dart';
import 'package:godartadmin/locator.dart';
import 'package:godartadmin/services/navigation_service.dart';

class NavBarItems extends StatelessWidget {
  final String? title;
  final String navigationPath;

  final IconData icon;

  const NavBarItems(
      {Key? key, this.title, required this.icon, required this.navigationPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.redAccent.withAlpha(25),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: ListTile(
          leading: Icon(
            icon,
            size: 23,
            color: Colors.black54,
          ),
          title: Text(
            title!,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontFamily: 'Airbnb Cereal Medium'),
          ),
        ),
      ),
      onTap: () {
        locator<NavigationService>().navigateTo(navigationPath);
      },
    );
  }
}
