import 'package:flutter/material.dart';
import 'package:godartadmin/const/colors.dart';

class OrderServices {
  static Color statusColor(document) {
    if (document.data()['orderStatus'] == 'Rejected' ||
        document.data()['orderStatus'] == 'Canceled') {
      return redColor;
    }

    if (document.data()['orderStatus'] == 'Completed') {
      return greenColor;
    }

    return ongoingColor;
  }

  Color bkgStatusColor(document) {
    if (document.data()['orderStatus'] == 'Rejected' ||
        document.data()['orderStatus'] == 'Canceled') {
      return redAlpha;
    }
    if (document.data()['orderStatus'] == 'Completed') {
      return greenAlpha;
    }

    return ongoingAlpha;
  }

  static String statusDesc(document) {
    if (document.get('orderStatus') == 'Rejected') {
      return 'Declined';
    }

    if (document.get('orderStatus') == 'Canceled') {
      return 'Canceled';
    }
    if (document.get('orderStatus') == 'Completed') {
      return 'Completed';
    }
    return 'Ongoing';
  }
}
