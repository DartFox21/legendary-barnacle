import 'package:flutter/material.dart';
import 'package:godartadmin/models/navbar_item_data.dart';
import 'package:godartadmin/responsive/orientation_layout.dart';
import 'package:godartadmin/responsive/screen_type_layout.dart';
import 'package:godartadmin/services/navigation_service.dart';
import 'package:godartadmin/widgets/navbar/navbar_options/navbar_options_desktop.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';
import 'navbar_options_mobile.dart';

class NavbarOptions extends StatelessWidget {
  final String? title;
  final String navigationPath;

  final IconData icon;
  final VoidCallback? tap;
  const NavbarOptions(
      {Key? key,
      this.title,
      required this.navigationPath,
      required this.icon,
      this.tap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: NavBarItemData(
          title: title!,
          iconData: icon,
          path: navigationPath,
          onTap: () => locator<NavigationService>().navigateTo(navigationPath)),
      child: ScreenTypeLayout(
        mobile: OrientationLayout(
          portrait: (context) => const NavbarOptionsMobilePort(),
          landscape: (context) => const NavbarOptionsMobileLand(),
        ),
        tablet: const NavbarOptionDesktop(),
        desktop: const NavbarOptionDesktop(),
      ),
    );
  }
}
