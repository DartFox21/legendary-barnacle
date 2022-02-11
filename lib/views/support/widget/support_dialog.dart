import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godartadmin/const/colors.dart';
import 'package:godartadmin/const/styles.dart';
import 'package:godartadmin/view_models/support_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/src/provider.dart';

class SupportDialog extends StatefulWidget {
  final DocumentSnapshot data;
  const SupportDialog({Key? key, required this.data}) : super(key: key);

  @override
  _SupportDialogState createState() => _SupportDialogState();
}

class _SupportDialogState extends State<SupportDialog> {
  var orders = FirebaseFirestore.instance.collection('orders');

  Widget item({required String title, required String desc, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: photoTitle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              )),
          const SizedBox(
            width: 5.0,
          ),
          Text(
            desc,
            style: photoTitle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: StreamBuilder<DocumentSnapshot>(
          stream: orders.doc(widget.data['orderId']).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 1.5,
              padding: const EdgeInsets.all(8),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                      ),
                      child: Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                    snapshot.data!.get('customerPhoto')),
                                radius: 30,
                              ),
                              Text(snapshot.data!.get('username'),
                                  style: photoTitle),
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Iconsax.sms_edit),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(widget.data['userEmail'].toString(),
                                      style: photoTitle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                              item(
                                  title: 'Order ID: ',
                                  desc: widget.data['orderId'].toString()),
                              snapshot.data!.get('type') == 'vendor'
                                  ? item(
                                      title: 'Vendor: ',
                                      desc: snapshot.data!
                                              .get('seller')['shopName'] ??
                                          '-')
                                  : item(
                                      title: 'Pickup: ',
                                      desc: snapshot.data!
                                              .get('pickup')['pickupAddress'] ??
                                          '-'),
                              item(
                                  title: 'Darter: ',
                                  desc: snapshot.data!.get('driver')['name'] ??
                                      '-'),
                              item(
                                  title: 'Drop-off: ',
                                  desc: snapshot.data!
                                          .get('destinationAddress') ??
                                      '-'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Text(
                          'Ticket',
                          style: photoTitle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.shade400, width: .5),
                          ),
                          child: Text(
                            widget.data['details'],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                if (!widget.data['seen'])
                                  // ignore: curly_braces_in_flow_control_structures
                                  widget.data.reference
                                      .update({'seen': true}).whenComplete(
                                          () => Navigator.of(context).pop());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: widget.data['seen']
                                      ? Colors.transparent
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: widget.data['seen']
                                          ? Colors.transparent
                                          : Colors.grey.shade400,
                                      width: .5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.data['seen']
                                        ? 'Ticket Closed'
                                        : 'Close Ticket',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                            const SizedBox(width: 10.0),
                            Expanded(
                                child: InkWell(
                              onTap: () async {
                                if (!snapshot.data!.get('refunded')) {
                                  await context
                                      .read<SupportVM>()
                                      .initiateRefund(
                                          referenceId:
                                              snapshot.data!.get('reference'),
                                          orderId: widget.data['orderId'],
                                          cancelType:
                                              widget.data['complainer']);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: !snapshot.data!.get('refunded')
                                      ? greenAlpha
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.transparent, width: .5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data!.get('refunded')
                                        ? 'Refund Issued'
                                        : 'Issue Refund',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: !snapshot.data!.get('refunded')
                                          ? greenColor
                                          : Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
