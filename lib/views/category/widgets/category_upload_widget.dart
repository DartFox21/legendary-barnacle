import 'dart:html';

import 'package:flutter/material.dart';

import 'package:firebase/firebase.dart' as fb;
import 'package:godartadmin/const/colors.dart';
import 'package:godartadmin/services/fb_services.dart';
import 'package:godartadmin/widgets/buttons/login_btn.dart';

class CategoryCreateWidget extends StatefulWidget {
  const CategoryCreateWidget({Key? key}) : super(key: key);

  @override
  _CategoryCreateWidgetState createState() => _CategoryCreateWidgetState();
}

class _CategoryCreateWidgetState extends State<CategoryCreateWidget> {
  final FirebaseServices _services = FirebaseServices();
  final _fileNameTextController = TextEditingController();
  final _categoryNameTextController = TextEditingController();
  bool _visible = false;
  bool _imageSelected = true;
  late String _url;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey.withAlpha(25),
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Visibility(
              visible: _visible,
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 30,
                      child: TextField(
                        controller: _categoryNameTextController,
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'No category Name given',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 20)),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    AbsorbPointer(
                      absorbing: true,
                      child: SizedBox(
                          width: 200,
                          height: 30,
                          child: TextField(
                            controller: _fileNameTextController,
                            decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'No image selected',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.only(left: 20)),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                      child: const Text('Upload Image',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        uploadStorage();
                      },
                      btnColor: lightGrey,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    AbsorbPointer(
                      absorbing: _imageSelected,
                      child: CustomButton(
                        child: Text(
                          'Save New Category',
                          style: TextStyle(color: greenColor),
                        ),
                        onPressed: () {
                          // if (_categoryNameTextController.text.isEmpty) {
                          //   return _services.showMyDialog(
                          //       context: context,
                          //       title: 'Add New Category',
                          //       msg: 'New Category Name not given');
                          // }

                          // _services
                          //     .uploadCategoryImageToDb(
                          //         _url, _categoryNameTextController.text)
                          //     .then((downloadUrl) {
                          //   _services.showMyDialog(
                          //       title: 'New Category',
                          //       msg: 'Saved New Category Successfully',
                          //       context: context);
                          // });
                          _categoryNameTextController.clear();
                          _fileNameTextController.clear();
                        },
                        btnColor: greenAlpha,
                        // color: _imageSelected ? Colors.black12 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _visible ? false : true,
              child: CustomButton(
                child: Text('Add New Category',
                    style: TextStyle(color: greenColor)),
                onPressed: () {
                  setState(() {
                    _visible = true;
                  });
                },
                btnColor: greenAlpha,
              ),
            )
          ],
        ),
      ),
    );
  }

  void uploadImage({required Function(File file) onSelected}) {
    var uploadInput = FileUploadInputElement()
      ..accept = 'image/*'; //it will upload only image
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });

    //selected image
  }

  void uploadStorage() {
    //upload selected image to Firebase storage
    final dateTime = DateTime.now();
    final path = 'CategoryImage/$dateTime';
    uploadImage(onSelected: (file) {
      setState(() {
        _fileNameTextController.text = file.name;
        _imageSelected = false;
        _url = path;
      });
      fb
          .storage()
          .refFromURL('gs://godart-60d60.appspot.com')
          .child(path)
          .put(file);
    });
  }
}
