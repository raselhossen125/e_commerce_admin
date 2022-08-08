import 'package:cloud_firestore/cloud_firestore.dart';

class DBHelper {
  static const adminCollection = 'Admins';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async {
    final snapshort = await _db.collection(adminCollection).doc(uid).get();
    return snapshort.exists;
  }
}
