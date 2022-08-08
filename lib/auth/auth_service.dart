import 'package:e_commerce_admin/db/db_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? get user => _auth.currentUser;

  static Future<bool> logIn(String email, String password) async {
    final credensial = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return DBHelper.isAdmin(credensial.user!.uid);
  }

  static Future<void> logOut() => _auth.signOut();
}