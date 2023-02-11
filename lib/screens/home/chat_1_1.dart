import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/chat_model.dart';
import 'package:flutter_application_1/models/messege_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatTwoPerson extends StatelessWidget {
  final String currentUser;
  final String friendId;
  final String friendName;

  ChatTwoPerson({
    super.key,
    required this.currentUser,
    required this.friendId,
    required this.friendName,
  });

  var currentUserid = FirebaseAuth.instance.currentUser!.uid;
  dynamic chatId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(friendName),
          centerTitle: true,
        ),
        body: Column(children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('app_users')
                  .doc(currentUserid)
                  .collection('messages')
                  .doc(friendId)
                  .collection('chat')
                  .orderBy("date", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        bool isMe = snapshot.data!.docs[index]['senderId'] ==
                            currentUser;
                        return SinglMessage(
                            message: snapshot.data!.docs[index]['message'],
                            isMe: isMe);
                      });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )),
          MessageTextField(currentId: currentUserid, friendid: friendId),
        ]));
  }
}
