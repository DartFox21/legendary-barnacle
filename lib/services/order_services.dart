import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Color driverStatusColor(document) {
    late Color col;
    if (document.exists) {
      if (document.get('active') == true) {
        col = ongoingColor;
      } else if (document.get('active') == false) {
        col = greenColor;
      }
    } else {
      col = redColor;
    }

    return col;
  }

  static String driverStatusDesc(document) {
    late String desc;
    if (document.exists) {
      if (document.get('active') == true) {
        desc = 'Busy';
      }

      if (document.get('active') == false) {
        desc = 'Available';
      }
    } else {
      desc = 'Offline';
    }

    return desc;
  }

  static Color dbkgStatusColor(document) {
    late Color col;
    if (document.exists) {
      if (document.get('active') == true) {
        col = ongoingAlpha;
      } else if (document.get('active') == false) {
        col = greenAlpha;
      }
    } else {
      col = redAlpha;
    }

    return col;
  }
}
