import 'package:flutter/material.dart';
import 'package:godartadmin/enum/device_screen_type.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;

  if (deviceWidth >= 950) {
    return DeviceScreenType.desktop;
  }

  if (deviceWidth > 600 && deviceWidth < 950) {
    return DeviceScreenType.tablet;
  }

  return DeviceScreenType.mobile;
}
