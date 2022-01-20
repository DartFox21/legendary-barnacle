import 'package:flutter/material.dart';
import 'package:godartadmin/const/colors.dart';

import 'package:intl/intl.dart';

class RevenueData extends StatefulWidget {
  final String title;
  final double amount;
  const RevenueData({Key? key, required this.title, required this.amount})
      : super(key: key);

  @override
  State<RevenueData> createState() => _RevenueDataState();
}

class _RevenueDataState extends State<RevenueData> {
  var formatMoney = NumberFormat.currency(locale: 'en_US', symbol: '');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: '${widget.title} \n\n',
                style: TextStyle(color: lightGrey, fontSize: 16)),
            TextSpan(
                text: '\₦${formatMoney.format(widget.amount)}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ])),
    );
  }
}
