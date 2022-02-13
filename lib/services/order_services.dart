import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:godartadmin/const/colors.dart';
import 'package:godartadmin/models/order_status.dart';
import 'package:godartadmin/services/fb_services.dart';

class OrderServices {
  final FirebaseServices _services = FirebaseServices();
  Future<void> arrivedAtPickUp(DocumentSnapshot document) async {
    try {
      EasyLoading.show(
        status: 'Updating..',
      );
      if (document.get('type') == 'vendor') {
        await _services.updateUserData('orders', document.get('orderId'), {
          'driver.status': OrderStatus.arrivedStore,
          'orderStatus': OrderStatus.pendingPickup,
          'driver.arrivePickup': DateTime.now().toString(),
        }).then((value) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('updated');
        });
      } else {
        await _services.updateUserData('orders', document.get('orderId'), {
          'driver.status': OrderStatus.arrivedAtPick,
          'orderStatus': OrderStatus.pendingPickup,
          'driver.arrivePickup': DateTime.now().toString(),
        }).then((value) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('updated');
        });
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong');
    }
  }

  Future<void> confirmPickUp(DocumentSnapshot document) async {
    try {
      EasyLoading.show(
        status: 'Updating..',
      );
      if (document.get('type') == 'vendor') {
        await _services.updateUserData('orders', document.get('orderId'), {
          'driver.status': OrderStatus.orderOnWay,
          'orderStatus': OrderStatus.orderOnWay,
          'driver.pickupTime': DateTime.now().toString(),
          'seller.completed': true,
        }).then((value) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('updated');
        });
      } else {
        await _services.updateUserData('orders', document.get('orderId'), {
          'driver.status': OrderStatus.packageOnWay,
          'orderStatus': OrderStatus.packageOnWay,
          'driver.pickupTime': DateTime.now().toString(),
        }).then((value) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('updated');
        });
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong');
    }
  }

  Future<void> confirmDelivery(DocumentSnapshot document) async {
    try {
      EasyLoading.show(
        status: 'Updating..',
      );
      await _services.updateUserData('orders', document.get('orderId'), {
        'driver.status': OrderStatus.orderComplete,
        'orderStatus': OrderStatus.completed,
        'driver.deliveryTime': DateTime.now().toString(),
      }).then((value) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('updated');
      });
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong');
    }
  }

  Future<void> arrivedDestination(DocumentSnapshot document) async {
    try {
      EasyLoading.show(
        status: 'Updating..',
      );
      if (document.get('type') == 'vendor') {
        await _services.addTotalRidesType(
            id: document.get('driver')['id'], item: 'punctualCount');

        await _services.updateUserData('orders', document.get('orderId'), {
          'driver.status': OrderStatus.orderIsHere,
          'orderStatus': OrderStatus.UrOrderIsHere,
          'driver.deliveryTime': DateTime.now().toString(),
          'driver.distance': '0',
        }).then((value) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('updated');
        });
      } else {
        /// check whether delivery was made on time

        await _services.addTotalRidesType(
            id: document.get('driver')['id'], item: 'punctualCount');

        await _services.updateUserData('orders', document.get('orderId'), {
          'driver.status': OrderStatus.orderAtDestination,
          'orderStatus': OrderStatus.packageHasArrived,
          'driver.deliveryTime': DateTime.now().toString(),
          'driver.distance': '0',
        }).then((value) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('updated');
        });
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong');
    }
  }

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

  static String statusText(document) {
    String status = 'none';
    if (document.get('orderStatus') == OrderStatus.driverHeadingToPickup ||
        document.get('orderStatus') == OrderStatus.driverHeadingToStore) {
      status = 'Arrived Pickup';
    } else if (document.get('orderStatus') == OrderStatus.pendingPickup) {
      status = 'Confirm Pickup';
    } else if (document.get('orderStatus') == OrderStatus.orderOnWay ||
        document.get('orderStatus') == OrderStatus.packageOnWay) {
      status = 'Arrived Destination';
    } else if (document.get('orderStatus') == OrderStatus.packageHasArrived ||
        document.get('orderStatus') == OrderStatus.UrOrderIsHere) {
      status = 'Complete Delivery';
    }
    return status;
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
