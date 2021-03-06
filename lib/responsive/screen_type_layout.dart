import 'package:flutter/material.dart';
import 'package:godartadmin/enum/device_screen_type.dart';

import 'responsive_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
  // Mobile will be returned by default
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenTypeLayout(
      {Key? key,
      required this.mobile,
      required this.tablet,
      required this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      // If sizing indicates Tablet and we have a tablet widget then return
      if (sizingInformation.deviceType == DeviceScreenType.tablet) {
        return tablet;
      }

      // If sizing indicates desktop and we have a desktop widget then return
      if (sizingInformation.deviceType == DeviceScreenType.desktop) {
        return desktop;
      }

      // Return mobile layout if nothing else is supplied
      return mobile;
    });
  }
}
