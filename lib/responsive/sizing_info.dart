import 'package:flutter/material.dart';
import 'package:godartadmin/enum/device_screen_type.dart';

class SizingInfo {
  final DeviceScreenType deviceType;

  final Size screenSize;

  final Size localWidgetSize;

  SizingInfo(
      {required this.deviceType,
      required this.screenSize,
      required this.localWidgetSize});

  @override
  String toString() {
    return 'DeviceType:$deviceType ScreenSize:$screenSize LocalWidgetSize:$localWidgetSize';
  }
}
