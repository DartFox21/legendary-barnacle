import 'package:flutter/material.dart';
import 'package:godartadmin/const/styles.dart';

class DocCards extends StatelessWidget {
  final String title;
  final String? desc;
  const DocCards({Key? key, required this.title, this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 90,
      decoration: BoxDecoration(
        color: Colors.redAccent.withAlpha(50),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              title,
              style: photoTitle.copyWith(
                color: Colors.red,
                fontSize: 13.0,
              ),
            ),
          ),
          Text(
            desc ?? '',
            style: photoTitle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 11.0,
            ),
          ),
        ],
      ),
    );
  }
}
