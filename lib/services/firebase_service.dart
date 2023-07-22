import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

const userCollection = 'users';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Map? currentUser;

  FirebaseService();

  /// The `loginUser` function attempts to sign in a user with the provided email address and password,
  ///-and returns a boolean indicating whether the login was successful or not.
  ///
  /// Args:
  ///   emailAddress (String): The email address entered by the user for login authentication. <br>
  ///   password (String): The password parameter is a required string that represents the user's password
  /// for authentication.
  ///
  /// Returns:
  ///   The `loginUser` function returns a `Future<bool>`.
  Future<bool> loginUser(
      {required String emailAddress, required String password}) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      if (credential.user != null) {
        currentUser = await getUserData(uid: credential.user!.uid);
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (error.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return false;
      } else {
        return false;
      }
    }
  }

  /// The function `getUserData` retrieves user data from a Firestore document based on the provided user
  /// ID.
  ///
  /// Args:
  ///   uid (String): The `uid` parameter is a required `String` that represents the unique identifier of
  /// a user.
  ///
  /// Returns:
  ///   a Future object that resolves to a Map.

  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot doc = await _db.collection(userCollection).doc(uid).get();
    return doc.data() as Map;
  }
}
