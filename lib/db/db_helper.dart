import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/model/product_model.dart';
import 'package:e_commerce_admin/model/purchase_model.dart';

import '../model/category_model.dart';

class DBHelper {
  static const adminCollection = 'Admins';
  static const categoriesCollection = 'Categories';
  static const productsCollection = 'Products';
  static const purchaseCollection = 'Purchase';
  static const usersCollection = 'Users';
  static const ordersCollection = 'Orders';
  static const ordersDetailsCollection = 'OrderDetails';
  static const settingsCollection = 'Settings';
  static const documentConstant = 'OrderConstant';
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

  static Future<void> rePurchase(PurchaseModel purchaseModel) {
    final doc = _db.collection(purchaseCollection).doc();
    purchaseModel.id = doc.id;
    return doc.set(purchaseModel.toMap());
  }

  static Future<void> addProduct(
    ProductModel productModel,
    PurchaseModel purchaseModel,
    String catId,
    num count,
  ) {
    final wb = _db.batch();
    final proDoc = _db.collection(productsCollection).doc();
    final purDoc = _db.collection(purchaseCollection).doc();
    final catDoc = _db.collection(categoriesCollection).doc(catId);
    productModel.id = proDoc.id;
    purchaseModel.id = purDoc.id;
    purchaseModel.productId = proDoc.id;
    wb.set(proDoc, productModel.toMap());
    wb.set(purDoc, purchaseModel.toMap());
    wb.update(catDoc, {CategoryProductCount: count});
    return wb.commit();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(categoriesCollection).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(productsCollection).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getProductById(
          String id) =>
      _db.collection(productsCollection).doc(id).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getPurchaseByProductId(
          String id) =>
      _db
          .collection(purchaseCollection)
          .where(PurchaseProductId, isEqualTo: id)
          .snapshots();

  static upDateProduct(String id, Map<String, dynamic> map) {
    return _db.collection(productsCollection).doc(id).update(map);
  }
}
