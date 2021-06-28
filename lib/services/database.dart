import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseOperations {
  getUserByUsername(String username) {}

  saveUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }
}
