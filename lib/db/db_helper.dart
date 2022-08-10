import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/category_model.dart';

class DBHelper {
  static const adminCollection = 'Admins';
  static const categoriesCollection = 'Categories';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async {
    final snapshort = await _db.collection(adminCollection).doc(uid).get();
    return snapshort.exists;
  }

  static Future<void> addNewCategory(CategoryModel categoryModel) {
    final doc = _db.collection(categoriesCollection).doc();
    categoryModel.catId = doc.id;
    return doc.set(categoryModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(categoriesCollection).snapshots();
}
