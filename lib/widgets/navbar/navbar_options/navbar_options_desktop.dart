import 'package:flutter/material.dart';
import 'package:godartadmin/models/base_model.dart';
import 'package:godartadmin/models/navbar_item_data.dart';

class NavbarOptionDesktop extends BaseModelWidget<NavBarItemData> {
  const NavbarOptionDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, NavBarItemData data) {
    return SizedBox(
      width: 200,
      child: Column(
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
