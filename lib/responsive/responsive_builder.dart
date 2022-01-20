import 'package:flutter/material.dart';
import 'package:godartadmin/utils/ui_utils.dart';

import 'sizing_info.dart';

class ResponsiveBuilder extends StatelessWidget {
  //builder function that returns a widget
  final Widget Function(BuildContext context, SizingInfo sizeInfo) builder;
  const ResponsiveBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return LayoutBuilder(builder: (context, boxSizing) {
      SizingInfo sizeInfo = SizingInfo(
        deviceType: getDeviceType(mediaQuery),
        screenSize: mediaQuery.size,
        localWidgetSize: Size(boxSizing.maxWidth, boxSizing.maxHeight),
      );

      return builder(context, sizeInfo);
    });
  }
}
