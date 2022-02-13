import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:godartadmin/const/colors.dart';
import 'package:godartadmin/services/fb_services.dart';
import 'package:godartadmin/services/order_services.dart';
import 'package:godartadmin/widgets/buttons/login_btn.dart';
import 'package:godartadmin/widgets/tables/table_head_txt.dart';
import 'package:godartadmin/widgets/texts/custom_text.dart';
import 'package:iconsax/iconsax.dart';

class DriverOnlineTable extends StatefulWidget {
  const DriverOnlineTable({Key? key}) : super(key: key);

  @override
  State<DriverOnlineTable> createState() => _DriverOnlineTableState();
}

class _DriverOnlineTableState extends State<DriverOnlineTable> {
  var users = FirebaseFirestore.instance.collection('workingDrivers');
  final FirebaseServices _services = FirebaseServices();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          height: 550,
          child: ListView(
            children: [
              Container(
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
                          text: 'Online Drivers',
                          color: lightGrey,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: users.snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return DataTable2(
                            columnSpacing: 12,
                            horizontalMargin: 12,
                            minWidth: 600,
                            columns: const [
                              DataColumn2(
                                label: TableHeader(title: 'Name'),
                                size: ColumnSize.L,
                              ),
                              DataColumn(
                                label: TableHeader(title: 'Rating'),
                              ),
                              DataColumn(
                                label: TableHeader(title: 'Mobile'),
                              ),
                              DataColumn2(
                                label: TableHeader(title: 'status'),
                                size: ColumnSize.L,
                              ),
                            ],
                            rows: _driverDetailRows(
                                snapshot.data!, _services, context),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
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
          document.get('firstname') ?? '-',
        ),
      ),
      DataCell(
        Row(
          children: [
            const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Text(
              document.get('rating').toString(),
            ),
          ],
        ),
      ),
      DataCell(
        Row(
          children: [
            const Icon(
              Iconsax.mobile,
            ),
            Text(
              document.get('mobile').toString(),
            ),
          ],
        ),
      ),
      DataCell(CustomButton(
          btnColor: OrderServices.dbkgStatusColor(document),
          child: CustomText(
            text: OrderServices.driverStatusDesc(document),
            color: OrderServices.driverStatusColor(document),
          ),
          onPressed: () {})),
    ]);
  }).toList();
  return newDataList;
}
