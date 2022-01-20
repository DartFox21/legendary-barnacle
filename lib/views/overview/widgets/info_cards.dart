import 'package:flutter/material.dart';

import 'package:godartadmin/const/colors.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? topColor;
  final bool isActive;

  const InfoCard(
      {Key? key,
      required this.title,
      required this.value,
      this.isActive = false,
      this.topColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 220,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$title\n',
              style: TextStyle(
                  fontSize: 16, color: isActive ? active : lightGrey)),
          Text(value,
              style: TextStyle(fontSize: 40, color: isActive ? active : dark)),
        ],
      ),
    );
  }
}
