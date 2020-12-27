import 'package:barter/event/chatEvent.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    print("getUserInfo email" + email);
    print(Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .toString());
    return Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    print("hellloooo");
    String result = "";
    Firestore.instance
        .collection("users")
        .where("username", isEqualTo: searchField)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}'));
    });

    //CollectionReference users = FirebaseFirestore.instance.collection('users')
    print("hellloooowwwwwww");
    print(result);
    return Firestore.instance
        .collection("users")
        .where("username", isEqualTo: searchField)
        .getDocuments();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  static Future<Stream<QuerySnapshot>> getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
    CoreLogic.instance.chatLogic.add(FetchChat());
  }

  static Future<Stream<QuerySnapshot>> getUserChats(String uid) async {
    return await Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: uid)
        .orderBy("chatDateTime", descending: true)
        .snapshots();
  }
}
