import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String userCollection = 'users';
const String postCollection = 'posts';

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

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required File profileImage,
  }) async {
    try {
      UserCredential newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String userUid = newUser.user!.uid;
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(profileImage.path);
      UploadTask task =
          _storage.ref('images/$userUid/$fileName').putFile(profileImage);
      return task.then((snapshot) async {
        String downloadURL = await snapshot.ref.getDownloadURL();
        await _db
            .collection(userCollection)
            .doc(userUid)
            .set({'name': name, 'email': email, 'image': downloadURL});
        return true;
      });
    } catch (error) {
      print(error);
      return false;
    }
  }

  /// The function `addImage` uploads an image file to Firebase storage and adds a corresponding document
  /// to a Firestore collection with the image URL and other details.
  ///
  /// Args:
  ///   addedImage (File): addedImage is a File object that represents the image file to be uploaded.
  ///
  /// Returns:
  ///   a `Future<bool>`.
  Future<bool> addImage(File addedImage) async {
    try {
      String userId = _auth.currentUser!.uid;
      String fileName = Timestamp.now().microsecondsSinceEpoch.toString() +
          p.extension(addedImage.path);
      // Initial a task to upload image to Firebase storage
      UploadTask task =
          _storage.ref('postImages/$userId/$fileName').putFile(addedImage);
      return task.then((snapshot) async {
        String downloadURL = await snapshot.ref.getDownloadURL();
        await _db.collection(postCollection).add({
          'userId': userId,
          'image': downloadURL,
          'timestamp': Timestamp.now()
        });
        return true;
      });
    } catch (error) {
      print(error);
      return false;
    }
  }

  /// The function returns a stream of query snapshots for posts, ordered by timestamp in descending
  /// order.
  ///
  /// Returns:
  ///   a Stream of QuerySnapshot objects.
  Stream<QuerySnapshot> getPosts() {
    return _db
        .collection(postCollection)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  /// The function returns a stream of query snapshots for posts belonging to the current user.
  ///
  /// Returns:
  ///   a Stream of QuerySnapshot.
  Stream<QuerySnapshot> getPostsOfUser() {
    String userID = _auth.currentUser!.uid;
    return _db
        .collection(postCollection)
        .where('userId', isEqualTo: userID)
        .orderBy('timestamp')
        .snapshots();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
