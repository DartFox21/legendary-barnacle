import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godartadmin/services/fb_services.dart';

import 'info_cards.dart';

class LargeCards extends StatefulWidget {
  const LargeCards({Key? key}) : super(key: key);

  @override
  State<LargeCards> createState() => _LargeCardsState();
}

class _LargeCardsState extends State<LargeCards> {
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  FirebaseServices fbService = FirebaseServices();
  int totalOrders = 0;
  int canceled = 0;
  int ongoing = 0;
  int completed = 0;
  int totalCustomers = 0;
  int totalDrivers = 0;
  int totalMerchant = 0;
  int refunds = 0;
  int pendingRiders = 0;
  int pendingMerchants = 0;

  Future<void> ridersPending() async {
    await fbService.drivers
        .where('verified', isEqualTo: false)
        .snapshots()
        .forEach((element) {
      setState(() {
        pendingRiders = element.size;
      });
    });
  }

  Future<void> vendorsPending() async {
    await fbService.vendors
        .where('verified', isEqualTo: false)
        .snapshots()
        .forEach((element) {
      setState(() {
        pendingMerchants = element.size;
      });
    });
  }

  Future<void> completedOrders() async {
    await orders
        .where('orderStatus', isEqualTo: 'Completed')
        .snapshots()
        .forEach((element) {
      setState(() {
        completed = element.size;
      });
    });
  }

  Future<void> refundedOrders() async {
    await orders
        .where('refunded', isEqualTo: true)
        .snapshots()
        .forEach((element) {
      setState(() {
        refunds = element.size;
      });
    });
  }

  Future<void> totalCustomer() async {
    await fbService.customers.snapshots().forEach((element) {
      setState(() {
        totalCustomers = element.size;
      });
    });
  }

  Future<void> totalVendors() async {
    await fbService.vendors.snapshots().forEach((element) {
      setState(() {
        totalMerchant = element.size;
      });
    });
  }

  Future<void> total() async {
    await orders.snapshots().forEach((element) {
      setState(() {
        totalOrders = element.size;
      });
    });
  }

  Future<void> totalRiders() async {
    await fbService.drivers.snapshots().forEach((element) {
      setState(() {
        totalDrivers = element.size;
      });
    });
  }

  Future<void> activeOrders() async {
    await orders
        .where('orderStatus', isNotEqualTo: 'Completed')
        .where('orderStatus', isNotEqualTo: 'Rejected')
        .where('orderStatus', isNotEqualTo: 'Canceled')
        .snapshots()
        .forEach((element) {
      setState(() {
        ongoing = element.size;
      });
    });
  }

  Future<void> canceledOrders() async {
    await orders
        .where('orderStatus', isEqualTo: 'Canceled')
        .snapshots()
        .forEach((element) {
      setState(() {
        canceled = element.size;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    canceledOrders();
    completedOrders();
    activeOrders();
    totalCustomer();
    totalRiders();
    total();
    totalVendors();
    refundedOrders();
    vendorsPending();
    ridersPending();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 20,
      spacing: 30,
      children: [
        InfoCard(
          title: 'Total Orders',
          value: totalOrders.toString(),
          topColor: Colors.orange,
        ),
        InfoCard(
          title: 'Ongoing Orders',
          value: ongoing.toString(),
          topColor: Colors.orange,
        ),
        InfoCard(
          title: 'Deliveries Completed',
          value: completed.toString(),
          topColor: Colors.lightGreen,
        ),
        InfoCard(
          title: 'Cancelled Deliveries',
          value: canceled.toString(),
          topColor: Colors.redAccent,
        ),
        InfoCard(
          title: 'Total Customers',
          value: totalCustomers.toString(),
        ),
        InfoCard(
          title: 'Total Riders',
          value: totalDrivers.toString(),
        ),
        InfoCard(
          title: 'Total Vendors',
          value: totalMerchant.toString(),
        ),
        InfoCard(
          title: 'Refunds Issued',
          value: refunds.toString(),
        ),
        InfoCard(
          title: 'Pending Riders',
          value: pendingRiders.toString(),
        ),
        InfoCard(
          title: 'Pending Merchants',
          value: pendingMerchants.toString(),
        ),
      ],
    );
  }
}
