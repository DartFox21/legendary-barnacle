import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godartadmin/services/fb_services.dart';

class SubCategoryWidget extends StatefulWidget {
  final String categoryName;

  const SubCategoryWidget({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  _SubCategoryWidgetState createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  final FirebaseServices _services = FirebaseServices();
  final _subCatNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<DocumentSnapshot>(
            future: _services.category.doc(widget.categoryName).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No Subcategories Added'),
                  );
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text('Main Category : '),
                            Text(
                              widget.categoryName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 3,
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(
                                snapshot.data!.get('subCat')[index]['name']),
                          );
                        },
                        itemCount: snapshot.data!.get('subCat') == null
                            ? 0
                            : snapshot.data!.get('subCat').length,
                      ),
                    ),
                    Column(
                      children: [
                        const Divider(
                          thickness: 4,
                        ),
                        Container(
                          color: Colors.grey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Add New Sub Category',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 30,
                                      child: TextField(
                                        controller: _subCatNameTextController,
                                        decoration: const InputDecoration(
                                          hintText: 'Sub Category Name',
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(),
                                          contentPadding:
                                              EdgeInsets.only(left: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    color: Colors.black54,
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      // if (_subCatNameTextController
                                      //     .text.isEmpty) {
                                      //   return _services.showMyDialog(
                                      //     context: context,
                                      //     title: 'Add New SubCategory',
                                      //     msg:
                                      //         'Need to Give Subcategory Name',
                                      //   );
                                      // }
                                      DocumentReference doc = _services.category
                                          .doc(widget.categoryName);
                                      doc.update({
                                        'subCat': FieldValue.arrayUnion([
                                          {
                                            'name':
                                                _subCatNameTextController.text
                                          }
                                        ]),
                                      });
                                      //if u want to see the update real time.
                                      setState(() {});
                                      //it will rerun entire widget tree, so update will show
                                      //after update clear edittext
                                      _subCatNameTextController.clear();
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
