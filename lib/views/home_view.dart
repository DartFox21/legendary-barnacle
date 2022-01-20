import 'package:flutter/material.dart';
import 'package:godartadmin/responsive/orientation_layout.dart';
import 'package:godartadmin/responsive/screen_type_layout.dart';

import 'package:godartadmin/views/home/home_view_desktop.dart';

import 'home/home_view_m_land.dart';
import 'home/home_view_m_port.dart';
import 'home/home_view_tablet.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => HomeViewMPortrait(),
        landscape: (context) => const HomeViewMLandscape(),
      ),
      tablet: const HomeViewTablet(),
      desktop: const HomeViewDesktop(),
    );
  }
}
