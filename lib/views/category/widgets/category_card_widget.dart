import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'subcategory_widget.dart';

class CategoryCard extends StatelessWidget {
  final DocumentSnapshot document;
  const CategoryCard({
    Key? key,
    required this.document,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return SubCategoryWidget(categoryName: document['name']);
        //     });
      },
      child: SizedBox(
        height: 120,
        width: 120,
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Image.network(document['image']),
                  ),
                  FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        document['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
