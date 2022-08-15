// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/db/db_helper.dart';
import 'package:e_commerce_admin/model/date_model.dart';
import 'package:e_commerce_admin/model/product_model.dart';
import 'package:e_commerce_admin/model/purchase_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../model/category_model.dart';

class ProductProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
  List<PurchaseModel> purchaseListOfSpecefixProduct = [];

  Future<void> addCategory(CategoryModel categoryModel) =>
      DBHelper.addNewCategory(categoryModel);

  Future<void> rePurchase(String pId, num price, num quantity, DateTime date) {
    final purchaseModel = PurchaseModel(
      dateModel: DateModel(
        timestamp: Timestamp.fromDate(date),
        day: date.day,
        month: date.month,
        year: date.year,
      ),
      purchasePrice: price,
      productQuantity: quantity,
      productId: pId,
    );
    return DBHelper.rePurchase(purchaseModel);
  }

  Future<void> addNewProduct(
    ProductModel productModel,
    PurchaseModel purchaseModel,
    CategoryModel categoryModel,
  ) {
    final count = categoryModel.count + purchaseModel.productQuantity;
    return DBHelper.addProduct(
        productModel, purchaseModel, categoryModel.catId!, count);
  }

  getAllcategories() {
    DBHelper.getAllCategories().listen((snapsort) {
      categoryList = List.generate(snapsort.docs.length,
          (index) => CategoryModel.fromMap(snapsort.docs[index].data()));
      notifyListeners();
    });
  }

  getAllProducts() {
    DBHelper.getAllProducts().listen((snapsort) {
      productList = List.generate(snapsort.docs.length,
          (index) => ProductModel.fromMap(snapsort.docs[index].data()));
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProductById(String id) =>
      DBHelper.getProductById(id);

  getPurchaseByProduct(String id) {
    DBHelper.getPurchaseByProductId(id).listen((snapsort) {
      purchaseListOfSpecefixProduct = List.generate(snapsort.docs.length,
          (index) => PurchaseModel.fromMap(snapsort.docs[index].data()));
      print(purchaseListOfSpecefixProduct.length);
      notifyListeners();
    });
  }

  CategoryModel getCategoryModelByCatName(String name) {
    return categoryList.firstWhere((element) => element.catName == name);
  }

  Future<void> updateproduct(String id, String field, dynamic value) {
    return DBHelper.upDateProduct(id, {field: value});
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
