import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:godartadmin/services/api.dart';
import 'package:godartadmin/services/fb_services.dart';

class SupportVM with ChangeNotifier {
  final FirebaseServices _services = FirebaseServices();

  final Api _api = Api();
  Future<void> initiateRefund({
    required String referenceId,
    required String orderId,
    required String cancelType,
  }) async {
    try {
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.ring
        ..userInteractions = false
        ..dismissOnTap = false;
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
