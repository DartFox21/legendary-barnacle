import 'package:flutter/material.dart';
import 'package:godartadmin/models/base_model.dart';
import 'package:godartadmin/models/navbar_item_data.dart';

class NavbarOptionsMobilePort extends BaseModelWidget<NavBarItemData> {
  const NavbarOptionsMobilePort({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, NavBarItemData data) {
    return Container(
      padding: const EdgeInsets.only(left: 25),
      height: 80,
      child: Row(
        children: <Widget>[
          InkWell(
            hoverColor: Colors.redAccent.withAlpha(25),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: ListTile(
                leading: Icon(
                  data.iconData,
                  size: 23,
                  color: Colors.black54,
                ),
                title: Text(
                  data.title,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                      fontFamily: 'Airbnb Cereal Medium'),
                ),
              ),
            ),
            onTap: data.onTap,
          ),
        ],
      ),
    );
  }
}

class NavbarOptionsMobileLand extends BaseModelWidget<NavBarItemData> {
  const NavbarOptionsMobileLand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, NavBarItemData data) {
    return Container(
      height: 70,
      alignment: Alignment.center,
      child: InkWell(
        hoverColor: Colors.redAccent.withAlpha(25),
        onTap: data.onTap,
        child: Icon(
          data.iconData,
          size: 30,
        ),
      ),
    );
  }
}
