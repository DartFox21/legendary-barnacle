import 'package:flutter/material.dart';

import 'widgets/category_list_widget.dart';
import 'widgets/category_upload_widget.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              const Text('Add New Categories and Sub Categories'),
              const Divider(
                thickness: 5,
              ),
              const CategoryCreateWidget(),
              const Divider(
                thickness: 5,
              ),
              CategoryListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
