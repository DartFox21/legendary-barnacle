import 'package:flutter/material.dart';
import 'package:godartadmin/const/styles.dart';

class TableHeader extends StatelessWidget {
  final String title;
  const TableHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: tableStyle);
  }
}
