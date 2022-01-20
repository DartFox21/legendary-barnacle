import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godartadmin/const/colors.dart';

import 'package:intl/intl.dart';

import 'revenue_data.dart';

class RevenueDataLarge extends StatefulWidget {
  const RevenueDataLarge({Key? key}) : super(key: key);

  @override
  State<RevenueDataLarge> createState() => _RevenueDataLargeState();
}

class _RevenueDataLargeState extends State<RevenueDataLarge> {
  CollectionReference users = FirebaseFirestore.instance.collection('orders');
  double totalTransaction = 0;
  double totalTransactionRefunded = 0;
  double totalDriverPayOut = 0;
  double totalTransactionPackage = 0;
  double totalTransactionVendors = 0;
  double totalRev = 0;
  double totalRevPackage = 0;
  double totalRevVendors = 0;
  int ongoing = 0;
  int completed = 0;

  var formatMoney = NumberFormat.currency(locale: 'en_US', symbol: '');

  totalSales() async {
    await users
        .where('orderStatus', isEqualTo: 'Completed')
        .snapshots()
        .forEach((element) {
      for (var element in element.docChanges) {
        setState(() {
          totalTransaction += element.doc.get('total');
        });
      }
    });
  }

  totalRefund() async {
    await users
        .where('refunded', isEqualTo: true)
        .snapshots()
        .forEach((element) {
      for (var element in element.docChanges) {
        setState(() {
          totalTransactionRefunded += element.doc.get('total');
        });
      }
    });
  }

  totalDeliveryPay() async {
    await users
        .where('orderStatus', isEqualTo: 'Completed')
        .snapshots()
        .forEach((element) {
      for (var element in element.docChanges) {
        setState(() {
          totalDriverPayOut += element.doc.get('deliveryFee');
        });
      }
    });
  }

  totalRevenue() async {
    await users
        .where('orderStatus', isEqualTo: 'Completed')
        .snapshots()
        .forEach((element) {
      for (var element in element.docChanges) {
        setState(() {
          totalRev += element.doc.get('serviceFee');
        });
      }
    });
  }

  totalRevenuePackage() async {
    await users
        .where('orderStatus', isEqualTo: 'Completed')
        .where('type', isEqualTo: 'package')
        .snapshots()
        .forEach((element) {
      for (var element in element.docChanges) {
        setState(() {
          totalRevPackage += element.doc.get('serviceFee');
        });
      }
    });
  }

  totalRevenueVendor() async {
    await users
        .where('orderStatus', isEqualTo: 'Completed')
        .where('type', isEqualTo: 'vendor')
        .snapshots()
        .forEach((element) {
      for (var element in element.docChanges) {
        setState(() {
          totalRevVendors += element.doc.get('serviceFee');
        });
      }
    });
  }

  totalPackageTransactions() async {
    await users
        .where('orderStatus', isEqualTo: 'Completed')
        .where('type', isEqualTo: 'package')
        .snapshots()
        .forEach((element) {
      for (var element in element.docChanges) {
        setState(() {
          totalTransactionPackage += element.doc.get('total');
        });
      }
    });
  }

  totalVendorTransactions() async {
    await users
        .where('orderStatus', isEqualTo: 'Completed')
        .where('type', isEqualTo: 'vendor')
        .snapshots()
        .forEach((element) {
      for (var element in element.docChanges) {
        setState(() {
          totalTransactionVendors += element.doc.get('total');
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    totalSales();
    totalVendorTransactions();
    totalPackageTransactions();
    totalRevenue();
    totalRevenueVendor();
    totalRevenuePackage();
    totalRefund();
    totalDeliveryPay();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    RevenueData(
                      title: 'Total Transactions',
                      amount: totalTransaction,
                    ),
                    RevenueData(
                      title: 'Total Revenue',
                      amount: totalRev,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    RevenueData(
                      title: 'Total Refunds',
                      amount: totalTransactionRefunded,
                    ),
                    RevenueData(
                      title: 'Total Deliveries',
                      amount: totalDriverPayOut,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 120,
            color: lightGrey,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    RevenueData(
                      title: 'Package Transactions',
                      amount: totalTransactionPackage,
                    ),
                    RevenueData(
                      title: 'Merchants Transacations',
                      amount: totalTransactionVendors,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    RevenueData(
                      title: 'Package Service',
                      amount: totalRevPackage,
                    ),
                    RevenueData(
                      title: 'Merchant Service',
                      amount: totalRevVendors,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
