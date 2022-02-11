import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirebaseServices {
  static const banner = 'slider';
  static const admin = 'admin';
  static const vendor = 'vendors';

  CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  final FirebaseStorage _storage = FirebaseStorage.instance;
  CollectionReference vendors =
      FirebaseFirestore.instance.collection('vendors');
  CollectionReference drivers =
      FirebaseFirestore.instance.collection('drivers');
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  CollectionReference working =
      FirebaseFirestore.instance.collection('workingDrivers');

  final FirebaseFirestore _fb = FirebaseFirestore.instance;
  Future<DocumentSnapshot> getAdminCred(String id) {
    // id in collection is equal distinct username
    var res = FirebaseFirestore.instance.collection(admin).doc(id).get();
    return res;
  }

  uploadImgToCollection(String? url) async {
    // image not saving to collection
    String downloadURL = await _storage
        .ref('gs://godart-60d60.appspot.com/${url!}')
        .getDownloadURL();
    FirebaseFirestore.instance.collection(banner).add({
      'image': downloadURL,
    });
    return downloadURL;
  }

  Future<void> showDeleteDialog(
      {required String title,
      required String msg,
      required BuildContext context,
      required String id}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                deleteBannerImage(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog(
      {required BuildContext context,
      required String title,
      required String msg}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  deleteBannerImage(id) async {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(
      status: 'Deleting..',
    );
    try {
      await FirebaseFirestore.instance.collection(banner).doc(id).delete();
      EasyLoading.dismiss();
      EasyLoading.showSuccess('deleted');
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong');
    }
  }

  updateVendorStatus(
      {required String id,
      required bool currStatus,
      required String type}) async {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(
      status: 'Updating..',
    );
    try {
      await _fb.collection(vendor).doc(id).update({
        type: currStatus ? false : true,
      });
      EasyLoading.dismiss();
      EasyLoading.showSuccess('updated');
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong');
    }
  }

  updateDriverStatus(
      {required String id,
      required bool currStatus,
      required String type}) async {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(
      status: 'Updating..',
    );
    try {
      await drivers.doc(id).update({
        type: currStatus ? false : true,
      });
      EasyLoading.dismiss();
      EasyLoading.showSuccess('updated');
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong');
    }
  }

  Future<String> uploadCategoryImageToDb(String url, String catName) async {
    String downloadUrl = await _storage.ref(url).getDownloadURL();
    category.doc(catName).set({
      'image': downloadUrl,
      'name': catName,
    });
    return downloadUrl;
  }

  updateOrder({required String id, required String canceledBy}) async {
    try {
      await orders.doc(id).update({
        'refunded': true,
        'orderStatus': 'Canceled',
        'cancel.cancelType': canceledBy,
        'refundTimestamp': DateTime.now().toString(),
      });
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }

  Future<DocumentSnapshot> driverStatus({
    required String id,
  }) async {
    return await working.doc(id).get();
  }
}
