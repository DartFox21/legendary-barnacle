import 'package:flutter/material.dart';

import 'package:godartadmin/responsive/screen_type_layout.dart';
import 'package:godartadmin/routing/route_names.dart';
import 'package:godartadmin/widgets/navbar/navbar_desktop.dart';
import 'package:iconsax/iconsax.dart';

import 'navbar/navbar_mobile.dart';
import 'navbar/navbar_options/navbar_options.dart';
import 'navbar/navbar_tablet_l.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  static List<Widget> getDrawerOptions() {
    return const [
      NavbarOptions(
        title: 'Overview',
        icon: Iconsax.trend_up,
        navigationPath: overviewRoute,
      ),
      NavbarOptions(
        title: 'Drivers',
        icon: Iconsax.truck,
        navigationPath: driversRoute,
      ),
      NavbarOptions(
          title: 'Merchants',
          icon: Iconsax.shop,
          navigationPath: merchantsRoute),
      NavbarOptions(
          title: 'Support',
          icon: Iconsax.message_2,
          navigationPath: supportRoute),
      NavbarOptions(title: 'Chat', icon: Iconsax.message, navigationPath: ''),
      NavbarOptions(
          title: 'Categories',
          icon: Iconsax.category,
          navigationPath: categoryRoute),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return const ScreenTypeLayout(
      mobile: NavbarMobile(),
      tablet: NavbarTabletLandscape(),
      desktop: NavbarDesktop(),
    );
  }
}
