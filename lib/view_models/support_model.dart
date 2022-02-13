import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:godartadmin/services/api.dart';
import 'package:godartadmin/services/fb_services.dart';
import 'package:godartadmin/services/order_services.dart';

class SupportVM with ChangeNotifier {
  final FirebaseServices _services = FirebaseServices();

  final OrderServices _order = OrderServices();

  final Api _api = Api();

  Future<void> checkLocation(DocumentSnapshot document) async {
    if (OrderServices.statusText(document) == 'Arrived Pickup') {
      await _order.arrivedAtPickUp(document);
    } else if (OrderServices.statusText(document) == 'Arrived Destination') {
      await _order.arrivedDestination(document);
    } else if (OrderServices.statusText(document) == 'Confirm Pickup') {
      await _order.confirmPickUp(document);
    } else if (OrderServices.statusText(document) == 'Complete Delivery') {
      await _order.confirmDelivery(document);
    }
  }

  Future<void> initiateRefund({
    required String referenceId,
    required String orderId,
    required String cancelType,
  }) async {
    try {
      EasyLoading.show(
        status: 'Canceling order..',
      );

      await _api.refund(referenceId).then((value) async {
        if (value) {
          await _services
              .updateOrder(id: orderId, canceledBy: cancelType)
              .whenComplete(() {
            EasyLoading.dismiss();
          });
        } else {
          EasyLoading.dismiss();
          EasyLoading.showError(
              'Something went wrong trying to initiate payment',
              duration: const Duration(seconds: 3));
        }
      });
    } catch (e) {
      debugPrint('$e');
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong trying to initiate payment',
          duration: const Duration(seconds: 3));
    }
  }
}
