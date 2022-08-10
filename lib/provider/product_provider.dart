import 'dart:io';

import 'package:e_commerce_admin/db/db_helper.dart';
import 'package:e_commerce_admin/model/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/category_model.dart';

class ProductProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];

  Future<void> addCategory(CategoryModel categoryModel) =>
      DBHelper.addNewCategory(categoryModel);

  getAllcategories() {
    DBHelper.getAllCategories().listen((snapsort) {
      categoryList = List.generate(snapsort.docs.length,
          (index) => CategoryModel.fromMap(snapsort.docs[index].data()));
      notifyListeners();
    });
  }

  Future<String> updateImage(XFile xFile) async {
    final imagename = DateTime.now().millisecondsSinceEpoch.toString();
    final photoRefarance =
    FirebaseStorage.instance.ref().child('pictures/$imagename');
    final uploadtask = photoRefarance.putFile(File(xFile.path));
    final snapshort = await uploadtask.whenComplete(() => null);
    return snapshort.ref.getDownloadURL();
  }
}
