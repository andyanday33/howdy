import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseOperations {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
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

  getConversationMessages(String chatroomId, messageMap) {
    FirebaseFirestore.instance
        .collection("conversationRooms")
        .doc(chatroomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) => {print(e.toString())});
  }
}
