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

import 'merchant_dialog.dart';

class MerchantTable extends StatefulWidget {
  final String title;
  const MerchantTable({Key? key, required this.title}) : super(key: key);

  @override
  State<MerchantTable> createState() => _MerchantTableState();
}

class _MerchantTableState extends State<MerchantTable> {
  var users = FirebaseFirestore.instance.collection('vendors');
  final FirebaseServices _services = FirebaseServices();

  int? highRating;
  int? lowRating;
  double? sales;

  bool? topPicked;
  bool? activated;

  @override
  initState() {
    super.initState();
    if (mounted) filter(widget.title);
  }

  filter(String val) {
    switch (val) {
      case 'All Vendors':
        setState(() {
          topPicked = null;
          activated = null;
          highRating = null;
          lowRating = null;
          sales = null;
        });
        break;
      case 'Active':
        setState(() {
          activated = true;
          topPicked = null;
          highRating = null;
          lowRating = null;
          sales = null;
        });
        break;
      case 'Pending':
        setState(() {
          activated = false;
          topPicked = null;
          highRating = null;
          lowRating = null;
          sales = null;
        });
        break;
      case 'Top Picked':
        setState(() {
          topPicked = true;
          activated = null;
          highRating = null;
          lowRating = null;
          sales = null;
        });
        break;
      case 'Top Rated':
        setState(() {
          highRating = 4;
          topPicked = null;
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
        setState(() {
          lowRating = 2;
          topPicked = null;
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
                    text: 'Available Merchants',
                    color: lightGrey,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: users
                      .where('isTopPicked', isEqualTo: topPicked)
                      .where('verified', isEqualTo: activated)
                      .where('totalRatings', isGreaterThanOrEqualTo: highRating)
                      .where('totalRatings', isLessThanOrEqualTo: lowRating)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 600,
                      columns: const [
                        DataColumn(
                          label: TableHeader(title: 'Business Name'),
                        ),
                        DataColumn(
                          label: TableHeader(title: 'Account Status'),
                        ),
                        DataColumn(
                          label: TableHeader(title: 'Top Picked'),
                        ),
                        DataColumn(
                          label: TableHeader(title: 'Ratings'),
                        ),
                        DataColumn(
                          label: TableHeader(title: 'Actions'),
                        ),
                      ],
                      rows: _vendorDetailRows(snapshot.data!, _services),
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }

  List<DataRow> _vendorDetailRows(
      QuerySnapshot snapshots, FirebaseServices services) {
    List<DataRow> newDataList = snapshots.docs.map((DocumentSnapshot document) {
      return DataRow(cells: [
        DataCell(
          Text(
            document.get('shopName'),
          ),
        ),
        DataCell(document.get('verified')
            ? const Text(
                'Activated',
                style: TextStyle(color: Colors.green),
              )
            : const Text(
                'Pending',
                style: TextStyle(color: Colors.red),
              )),
        DataCell(document.get('isTopPicked')
            ? const Text(
                'Yes',
                style: TextStyle(color: Colors.green),
              )
            : const Text(
                'No',
                style: TextStyle(color: Colors.red),
              )),
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
          popMenu(
            context: context,
            services: services,
            activationStatus: document.get('verified'),
            deactivationStatus: document.get('deactivated'),
            isTopPicked: document.get('isTopPicked'),
            id: document.get('uid'),
            doc: document,
          ),
        ),
      ]);
    }).toList();
    return newDataList;
  }
}

Widget popMenu({
  required BuildContext context,
  bool published = true,
  required FirebaseServices services,
  required bool activationStatus,
  required bool deactivationStatus,
  required bool isTopPicked,
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
            await services.updateVendorStatus(
                type: 'verified', id: id, currStatus: activationStatus);
            break;

          case 'Deactivate':
            await services.updateVendorStatus(
                type: 'deactivated', id: id, currStatus: deactivationStatus);
            break;
          case 'TopPicked':
            await services.updateVendorStatus(
                type: 'isTopPicked', id: id, currStatus: isTopPicked);
            break;
          case 'Details':
            if (doc.get('shopName') == null ||
                doc.get('contents') == null ||
                doc.get('imageUrl') == null ||
                doc.get('address') == null) {
              EasyLoading.showInfo(
                  'Vendor does not have necessary documents to proceed');
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MerchantDialog(id: id);
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
            PopupMenuItem<String>(
              value: 'TopPicked',
              child: ListTile(
                horizontalTitleGap: 0,
                leading: !isTopPicked
                    ? const Icon(Icons.star)
                    : const Icon(CupertinoIcons.refresh),
                title: !isTopPicked
                    ? const Text(
                        'Suggest',
                      )
                    : const Text(
                        'Un-suggest',
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
