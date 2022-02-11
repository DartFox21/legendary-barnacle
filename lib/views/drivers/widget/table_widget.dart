import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:godartadmin/const/colors.dart';
import 'package:godartadmin/services/fb_services.dart';
import 'package:godartadmin/widgets/drop_down.dart';
import 'package:godartadmin/widgets/tables/table_head_txt.dart';
import 'package:godartadmin/widgets/texts/custom_text.dart';
import 'package:iconsax/iconsax.dart';

import 'driver_dialog.dart';

class DriverTable extends StatefulWidget {
  final String title;
  const DriverTable({Key? key, required this.title}) : super(key: key);

  @override
  State<DriverTable> createState() => _DriverTableState();
}

class _DriverTableState extends State<DriverTable> {
  var users = FirebaseFirestore.instance.collection('drivers');

  final FirebaseServices _services = FirebaseServices();

  bool? topPicked;

  bool? deactivated;

  bool? activated;

  int? highRating;
  int? lowRating;
  double? sales;

  @override
  initState() {
    super.initState();
    if (mounted) filter(widget.title);
  }

  filter(String val) {
    switch (val) {
      case 'All Drivers':
        // do something
        setState(() {
          deactivated = null;
          activated = null;
          highRating = null;
          lowRating = null;
          sales = null;
        });
        break;
      case 'Active':
        // do something else

        setState(() {
          activated = true;
          deactivated = null;
          highRating = null;
          lowRating = null;
          sales = null;
        });
        break;
      case 'Pending':
        // do something
        setState(() {
          activated = false;
          deactivated = null;
          highRating = null;
          lowRating = null;
          sales = null;
        });
        break;
      case 'deactivated':
        // do something
        setState(() {
          deactivated = true;
          activated = null;
          highRating = null;
          lowRating = null;
          sales = null;
        });
        break;
      case 'Top Rated':
        // do something
        setState(() {
          highRating = 4;
          deactivated = null;
          activated = null;
          lowRating = null;
          sales = null; // high rated
        });
        break;
      // case 5:
      // // do something
      //   setState(() {
      //     rating = 4; // high rated
      //   });
      //   break;
      case 'Low rated':
        // do something
        setState(() {
          lowRating = 2;
          deactivated = null;
          activated = null;
          highRating = null;
          sales = null; // low rated
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                    text: 'Available Drivers',
                    color: lightGrey,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: users
                      .where('deactivated', isEqualTo: deactivated)
                      .where('verified', isEqualTo: activated)
                      .where('totalRatings', isGreaterThanOrEqualTo: highRating)
                      .where('totalRatings', isLessThanOrEqualTo: lowRating)
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
                          label: TableHeader(title: 'Name'),
                          size: ColumnSize.L,
                        ),
                        DataColumn(
                          label: TableHeader(title: 'Activation Status'),
                        ),
                        DataColumn(
                          // label: TableHeader(title: 'Rating'),
                          label: TableHeader(title: 'Mobile'),
                        ),
                        DataColumn2(
                          label: TableHeader(title: 'Email'),
                          size: ColumnSize.L,
                        ),
                        DataColumn(
                          label: TableHeader(title: 'Action'),
                        ),
                      ],
                      rows:
                          _driverDetailRows(snapshot.data!, _services, context),
                    );
                  }),
            ],
          ),
        ),
      ],
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
          document.get('firstname') ??
              '-' + ' ' + document.get('lastname') ??
              '-',
        ),
      ),
      DataCell(document.get('verified')
          ? const Text(
              'Active',
              style: TextStyle(color: Colors.green),
            )
          : const Text(
              'Pending',
              style: TextStyle(color: Colors.red),
            )),
      DataCell(
        Row(
          children: [
            const Icon(
              // Icons.star,
              // color: Colors.yellow,
              Iconsax.mobile,
            ),
            Text(
              // document.get('rating').toString(),
              document.get('mobile').toString(),
            ),
          ],
        ),
      ),
      DataCell(
        Text(
          document.get('email'),
        ),
      ),
      DataCell(popMenu(
        context: context,
        services: services,
        id: document.get('id'),
        activationStatus: document.get('verified'),
        deactivationStatus: document.get('deactivated'),
        doc: document,
      )),
    ]);
  }).toList();
  return newDataList;
}

Widget popMenu({
  required BuildContext context,
  bool published = true,
  required FirebaseServices services,
  required bool activationStatus,
  required bool deactivationStatus,
  required String id,
  required DocumentSnapshot doc,
}) {
  return DropDownMenu<String>(
      item: const ['this', 'that'],
      offset: const Offset(180, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      enabled: true,
      icon: const Icon(Icons.more_horiz_rounded),
      onSelected: (value) async {
        switch (value) {
          case 'Activate':
            if (doc.get('firstname') == null ||
                doc.get('vehicleBrand') == null ||
                doc.get('licensePhoto') == null) {
              EasyLoading.showInfo(
                  'Rider does not have necessary documents to proceed');
            } else {
              await services.updateDriverStatus(
                  type: 'verified', id: id, currStatus: activationStatus);
            }
            break;

          case 'Deactivate':
            if (doc.get('firstname') == null ||
                doc.get('vehicleBrand') == null ||
                doc.get('licensePhoto') == null) {
              EasyLoading.showInfo(
                  'Rider does not have necessary documents to proceed');
            } else {
              await services.updateDriverStatus(
                  type: 'deactivated', id: id, currStatus: deactivationStatus);
            }
            break;
          case 'Details':
            //

            if (doc.get('firstname') == null ||
                doc.get('vehicleBrand') == null ||
                doc.get('licensePhoto') == null) {
              EasyLoading.showInfo(
                  'Rider does not have necessary documents to proceed');
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DriverDialog(id: id);
                  });
            }

            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'Activate',
              child: ListTile(
                horizontalTitleGap: 0,
                title: !activationStatus
                    ? const Text('Verify')
                    : const Text('Un-verify'),
                leading: !activationStatus
                    ? const Icon(CupertinoIcons.paperplane_fill)
                    : const Icon(CupertinoIcons.refresh),
              ),
            ),
            PopupMenuItem<String>(
              value: 'Deactivate',
              child: ListTile(
                horizontalTitleGap: 0,
                leading: !deactivationStatus
                    ? const Icon(Icons.cancel)
                    : const Icon(CupertinoIcons.check_mark),
                title: !deactivationStatus
                    ? const Text(
                        'Deactivate',
                      )
                    : const Text(
                        'Activate',
                      ),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'Details',
              child: ListTile(
                horizontalTitleGap: 0,
                leading: Icon(CupertinoIcons.doc),
                title: Text(
                  'Docs',
                ),
              ),
            ),
          ]);
}
