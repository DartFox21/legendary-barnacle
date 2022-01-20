import 'package:flutter/material.dart';

///This class returns a widget based on the orientation of the device
class OrientationLayout extends StatelessWidget {
  final Widget Function(BuildContext context) landscape;
  final Widget Function(BuildContext context) portrait;
  const OrientationLayout({
    Key? key,
    required this.landscape,
    required this.portrait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return landscape(context);
    }

    return portrait(context);
  }
}
