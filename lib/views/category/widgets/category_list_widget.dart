import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godartadmin/services/fb_services.dart';

import 'category_card_widget.dart';

class CategoryListWidget extends StatelessWidget {
  CategoryListWidget({Key? key}) : super(key: key);
  final FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: _services.category.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong..'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Wrap(
            direction: Axis.horizontal,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return CategoryCard(
                document: document,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
