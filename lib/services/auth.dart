import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduation_project101/widgets/navigation_drawer.dart';

class Authentication {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<User> login(String email, String password) async {
    User _user;
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = userCredential.user;
      print(_user);
    } on FirebaseException catch (e) {
      print('$e');
    }
    return _user;
  }

  static Future<User> signUp(
    String email,
    String password,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;

      print(user);
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print('e');
    }
    return user;
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  static createUser(
      String fName, String lName, String email, String profilePicture) {
    CollectionReference ref = _firestore.collection('users');
    ref.add({
      'uId': auth.currentUser.uid,
      'fName': fName,
      'lName': lName,
      'email': email,
      'profilePicture': profilePicture
    });
  }

  uploadImage() {
    FirebaseFirestore.instance.collection('users/');
  }

  static signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final acc = await googleSignIn.signIn();
    final auth = await acc.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    final res = await _auth.signInWithCredential(credential);
    return res.user;
  }
}
