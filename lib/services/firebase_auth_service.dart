import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthservice{
 static final FirebaseAuth _auth =FirebaseAuth.instance;
 static User? get user => _auth.currentUser;

  static Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  static Future signOut() async {
    await _auth.signOut();
    print('signout');
  }
}
