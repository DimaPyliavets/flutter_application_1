import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/screens/home/chat_1_1.dart';

class MessegeFragment extends StatefulWidget {
  const MessegeFragment({super.key});

  @override
  State<MessegeFragment> createState() => _MessegeFragmentState();
}

class _MessegeFragmentState extends State<MessegeFragment> {
  UserModel? userModel;

  var myId = FirebaseAuth.instance.currentUser!.uid.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(
          Icons.message_rounded,
          size: 30.0,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        title: const Text(
          'Chat',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('app_users')
            .doc(myId)
            .collection('messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("error"),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var friendId = snapshot.data!.docs[index].id;
                //print(friendId);
                var lastSms = snapshot.data!.docs[index]['last_message'];
                return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('app_users')
                        .doc(friendId)
                        .get(),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.hasData) {
                        var friend = asyncSnapshot.data!;
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(
                                friend['name'][0].toString().toUpperCase()),
                          ),
                          title: Text(friend['name']),
                          subtitle: Text("$lastSms"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatTwoPerson(
                                          currentUser: myId,
                                          friendId: friend['uid'],
                                          friendName: friend['name'],
                                        )));
                          },
                        );
                      }
                      if (asyncSnapshot.hasError) {
                        return const Text('data');
                      }
                      return const LinearProgressIndicator();
                    });
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
