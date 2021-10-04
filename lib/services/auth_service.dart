import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
    (User user) => user?.uid,
  );

  //sign up
  Future<String> createUserWithEmailAndPassword(String email, String password, String name) async { //add status
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

    //update username, status
    var user = FirebaseAuth.instance.currentUser;
    user.updateDisplayName(name);
    await user.reload();
    return user.uid;
  }


  //sign in
  Future<String> signInWithEmailAndPassword(String email, String password) async {
      return (await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      )).user.uid;
  }

  //sign out
  Signout() {
    return _firebaseAuth.signOut();
  }


}