import 'package:flutter/material.dart';

import '../navigation_bar.dart';

class NavbarMobile extends StatelessWidget {
  const NavbarMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Container(
      width: orientation == Orientation.portrait ? 80 : 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            color: Colors.black12,
          )
        ],
      ),
      child: Column(
        children: NavBar.getDrawerOptions(),
      ),
    );
  }
}
