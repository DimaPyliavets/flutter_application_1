import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/messege_model.dart';
import 'package:flutter_application_1/models/user_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference flutterUsersCollection =
      FirebaseFirestore.instance.collection('app_users');
  final CollectionReference flutterMessageCollection4 =
      FirebaseFirestore.instance.collection('app_chat4');
  final CollectionReference flutterMessageCollection =
      FirebaseFirestore.instance.collection('app_chat');

  Future updateUserData(String name, String email) async {
    return await flutterUsersCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'image_profile': "",
      'status': "",
      'favourites': [],
    });
  }

  Future deleteUser() async {
    try {
      DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
          .deleteUserData();
      FirebaseAuth.instance.currentUser!.delete();
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future deleteUserData() async {
    await flutterUsersCollection.doc(uid).delete();
  }

  Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance
      .collection('app_users')
      .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((docs) => UserModel.fromMyList(docs.data()))
          .toList());

  /*Stream<List<MessageModel>> readMessages(String chatID, String users) =>
      FirebaseFirestore.instance
          .collection('app_chat')
          .doc(chatID)
          .collection('messages')
          .where('members', isEqualTo: users)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((docs) => MessageModel.fromMyList(docs.data()))
              .toList());*/

  /*Stream<List<ChatModel>> readChats() => FirebaseFirestore.instance
      .collection('app_chat')
      .where('senderId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((docs) => ChatModel.fromMyList(docs.data()))
          .toList());
*/
  Future<UserModel?> readCurrentUser() async {
    final currenUser = FirebaseAuth.instance.currentUser!;
    final getCurrentUser =
        FirebaseFirestore.instance.collection('app_users').doc(currenUser.uid);
    final snapshot = await getCurrentUser.get();
    return UserModel.fromMyList(snapshot.data()!);
  }

  /*Future<ChatModel?> readCurrentUserChats() async {
    final currenUser = FirebaseAuth.instance.currentUser!;
    final getCurrentUser = FirebaseFirestore.instance
        .collection('app_users')
        .where('senderId', isEqualTo: currenUser);
    final snapshot = await getCurrentUser.get();
    //return ChatModel.fromMyList(snapshot.data()!);
  }*/

  /*getUserChat() async {
    return flutterMessageCollection.doc(uid).snapshots();
  }

  Future createChat(String name, String id, String chatName) async {
    DocumentReference groupDecumentReference =
        await flutterMessageCollection4.add({
      "groupName": chatName,
      "groupIcon": "",
      "admin": id,
      "members": [],
      "groupId": "",
      "recenMessege": "",
      "recentMessegeSender": "",
    });

    await groupDecumentReference.update({
      "members": FieldValue.arrayUnion([uid]),
      "chatId": groupDecumentReference.id,
    });
    DocumentReference usersCollection = flutterUsersCollection.doc(uid);
    return await usersCollection.update({
      "favourites": FieldValue.arrayUnion([groupDecumentReference.id])
    });
  }*/
}
