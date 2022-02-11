import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:godartadmin/const/colors.dart';

import 'package:godartadmin/services/fb_services.dart';
import 'package:godartadmin/services/order_services.dart';
import 'package:godartadmin/view_models/support_model.dart';
import 'package:godartadmin/widgets/buttons/login_btn.dart';
import 'package:godartadmin/widgets/tables/table_head_txt.dart';
import 'package:godartadmin/widgets/texts/custom_text.dart';
import 'package:provider/src/provider.dart';

class RecentOrdersTable extends StatefulWidget {
  const RecentOrdersTable({Key? key}) : super(key: key);

  @override
  State<RecentOrdersTable> createState() => _RecentOrdersTableState();
}

class _RecentOrdersTableState extends State<RecentOrdersTable> {
  final FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CustomText(
                text: 'Recent Orders',
                color: lightGrey,
                weight: FontWeight.bold,
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: _services.orders
                  .where('refunded', isEqualTo: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(
                      label: TableHeader(title: 'Customer'),
                      size: ColumnSize.L,
                    ),
                    DataColumn(
                      label: TableHeader(title: 'Order ID'),
                    ),
                    DataColumn(
                      label: TableHeader(title: 'Order Status'),
                    ),
                    DataColumn2(
                      label: TableHeader(title: 'Actions'),
                      size: ColumnSize.L,
                    ),
                  ],
                  rows: _driverDetailRows(snapshot.data!, _services, context),
                );
              }),
        ],
      ),
    );
  }
}

List<DataRow> _driverDetailRows(
  QuerySnapshot snapshots,
  FirebaseServices services,
  BuildContext context,
) {
  List<DataRow> newDataList = snapshots.docs.map((DocumentSnapshot document) {
    return DataRow(cells: [
      DataCell(
        Text(
          document.get('username') ?? '--',
        ),
      ),
      DataCell(Text(
        document.get('orderId') ?? '--',
      )),
      DataCell(
        Row(
          children: [
            Text(
              OrderServices.statusDesc(document),
              style: TextStyle(color: OrderServices.statusColor(document)),
            ),
          ],
        ),
      ),
      DataCell(Row(children: [
        CustomButton(
            btnColor: lightGrey.withAlpha(20),
            onPressed: () async {
              await context.read<SupportVM>().initiateRefund(
                  referenceId: document.get('reference'),
                  orderId: document.get('orderId'),
                  cancelType: 'GoDart');
            },
            child: Text(
              'Refund',
              style: TextStyle(color: lightGrey),
            )),
      ])),
    ]);
  }).toList();
  return newDataList;
}
