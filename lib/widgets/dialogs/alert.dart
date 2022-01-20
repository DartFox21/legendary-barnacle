import 'package:flutter/material.dart';
import 'package:godartadmin/widgets/buttons/login_btn.dart';

Future<void> showMyDialog(
    String title, String desc, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              title,
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                desc,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: CustomButton(
              onPressed: () => Navigator.of(context).pop(),
              btnColor: Colors.transparent,
              child: const Text('Okay'),
            ),
          )
        ],
      );
    },
  );
}
