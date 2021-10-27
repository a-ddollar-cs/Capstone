import 'package:firebase_auth/firebase_auth.dart';



class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
    (User user) => user?.uid,
  );

  //get User ID
  Future<String> getCurrentID() async {
    return (await _firebaseAuth.currentUser).uid;
  }

  //get user info
  Future getUser() async {
    return (await _firebaseAuth.currentUser);
  }

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

  //reset pass
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

}

//validators to send error messages upon authentication
class EmailValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Must input an email";
    }
    return null;
  }
}


class NameValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Must input a name";
    }
    if(value.length < 2) {
      return "Name must be longer than two characters";
    }
    if(value.length > 50) {
      return "Name must be shorter than 50 characters";
    }

    return null;
  }
}


class PasswordValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Must input an password";
    }
    return null;
  }
}

