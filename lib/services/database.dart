import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseOperations {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  saveUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  createConversationRoom(String conversationRoomId, conversationRoomMap) {
    FirebaseFirestore.instance
        .collection("conversationRooms")
        .doc(conversationRoomId)
        .set(conversationRoomMap)
        .catchError((e) => {print(e.toString())});
  }
}
