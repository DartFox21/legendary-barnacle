import 'package:flutter/material.dart';
import 'package:godartadmin/widgets/dialogs/alert.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Color btnColor;
  final bool normal;
  final VoidCallback onPressed;
  const CustomButton(
      {Key? key,
      this.normal = true,
      required this.btnColor,
      required this.child,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: normal
          ? onPressed
          : () => showMyDialog(
              context: context,
              desc: 'Are you sure you want to proceed?',
              title: 'Confirm',
              func: onPressed),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          backgroundColor: MaterialStateProperty.all(btnColor)),
      child: child,
    );
  }
}
