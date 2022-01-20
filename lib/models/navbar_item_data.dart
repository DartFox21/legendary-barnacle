import 'package:flutter/material.dart';

class NavBarItemData {
  final String title;
  final IconData iconData;
  final String path;
  final VoidCallback onTap;

  NavBarItemData(
      {required this.title,
      required this.iconData,
      required this.path,
      required this.onTap});
}
