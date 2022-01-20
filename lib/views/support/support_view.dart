import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godartadmin/const/colors.dart';

import 'package:godartadmin/views/support/widget/support_dialog.dart';
import 'package:godartadmin/views/support/widget/ven_darter_dialog.dart';

class SupportView extends StatefulWidget {
  const SupportView({Key? key}) : super(key: key);

  @override
  State<SupportView> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportView> {
  var tickets = FirebaseFirestore.instance.collection('complaints');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
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
            //  padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: tickets
                          .where('details')
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return Opacity(
                              opacity:
                                  snapshot.data!.docs[index]['seen'] == true
                                      ? 0.35
                                      : 1.0,
                              child: ListTile(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          snapshot.data!
                                                  .docs[index]['isSupport']
                                              ? VendorDarterDialog(
                                                  data: snapshot
                                                      .data!.docs[index])
                                              : SupportDialog(
                                                  data: snapshot
                                                      .data!.docs[index]));
                                },
                                leading: Stack(
                                  children: [
                                    snapshot.data!.docs[index]['seen'] == true
                                        ? const Text('')
                                        : Positioned(
                                            left: 0,
                                            top: 20,
                                            child: Container(
                                              height: 5,
                                              width: 5,
                                              decoration: BoxDecoration(
                                                color: redColor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: redColor, width: .5),
                                              ),
                                            ),
                                          ),
                                    const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 30,
                                    ),
                                  ],
                                ),
                                title: Text(
                                  snapshot.data!.docs[index]['userEmail'],
                                  style: TextStyle(
                                    color: dark,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data!.docs[index]['details'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            color: redAlpha,
                          ),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
