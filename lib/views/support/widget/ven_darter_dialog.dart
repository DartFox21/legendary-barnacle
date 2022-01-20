import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godartadmin/const/colors.dart';
import 'package:godartadmin/const/styles.dart';
import 'package:iconsax/iconsax.dart';

class VendorDarterDialog extends StatefulWidget {
  final DocumentSnapshot data;
  const VendorDarterDialog({Key? key, required this.data}) : super(key: key);

  @override
  _VendorDarterDialogState createState() => _VendorDarterDialogState();
}

class _VendorDarterDialogState extends State<VendorDarterDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 1.5,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text(widget.data['title'], style: photoTitle),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('User ID: ',
                            style: photoTitle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(widget.data['userId'].toString(),
                            style: photoTitle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Text(
                          'Ticket',
                          style: photoTitle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10.0),
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
                                      : greenAlpha,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: widget.data['seen']
                                          ? Colors.transparent
                                          : greenColor,
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
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
