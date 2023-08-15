// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // _firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set({
      //   'userId': userCredential.user!.uid,
      //   'email': email,
      // }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential> createUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // _firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set({
      //   'userId': userCredential.user!.uid,
      //   'email': email,
      // });

      return userCredential;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<User?> getUser() async {
    try {
      User? user = _firebaseAuth.currentUser;
      return user;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  String getUserId() {
    return _firebaseAuth.currentUser!.displayName ?? 'Expense';
  }
}
