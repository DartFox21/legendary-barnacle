import 'package:flutter/material.dart';

class DropDownMenu<T> extends PopupMenuButton<T> {
  const DropDownMenu({
    Key? key,
    List<T>? item,
    required PopupMenuItemBuilder<T> itemBuilder,
    T? initialValue,
    required PopupMenuItemSelected<T> onSelected,
    PopupMenuCanceled? onCanceled,
    double? elevation,
    EdgeInsetsGeometry padding = const EdgeInsets.all(0),
    Widget? child,
    required Widget icon,
    required Offset offset,
    required bool enabled,
    required ShapeBorder shape,
    Color? color,
    bool? captureInheritedThemes,
  }) : super(
          key: key,
          itemBuilder: itemBuilder,
          icon: icon,
          initialValue: initialValue,
          elevation: elevation,
          onCanceled: onCanceled,
          onSelected: onSelected,
          shape: shape,
          child: child,
          color: color,
          enabled: enabled,
          padding: padding,
          offset: offset,
        );
}
