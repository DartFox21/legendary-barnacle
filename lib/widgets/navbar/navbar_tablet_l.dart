import 'package:flutter/material.dart';

import '../navbar_logo.dart';
import '../navigation_bar.dart';

class NavbarTabletLandscape extends StatelessWidget {
  const NavbarTabletLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          const NavBarLogo(),
          const SizedBox(
            height: 80,
          ),
          ...NavBar.getDrawerOptions(),
        ],
      ),
    );
  }
}
