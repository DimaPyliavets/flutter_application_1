import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/services/database.dart';

class CreateChat extends StatefulWidget {
  const CreateChat({super.key});

  @override
  State<CreateChat> createState() => _CreateChat();
}

class _CreateChat extends State<CreateChat> {
  UserModel? userModel;
  TextEditingController controllerSearchChat = TextEditingController();
  final TextEditingController controllerCreateChat = TextEditingController();
  bool _isLoading = false;
  String groupName = "";
  String userName = "";

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> searchResults = FirebaseFirestore.instance
        .collection("items")
        .where("name", isEqualTo: controllerSearchChat.text)
        .snapshots();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10.0),
            const Text(
              'Create Chat',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'CustomFont',
              ),
            ),
            const SizedBox(height: 30.0),
            TextField(
              onChanged: ((value) {
                setState(() {
                  groupName = value;
                });
              }),
              controller: controllerCreateChat,
              decoration: const InputDecoration(
                labelText: 'Name of chat',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                if (controllerCreateChat.text != "") {
                  setState(() {
                    //_isLoading = true;
                  });
                  /* DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                      .createGroups(
                          userName,
                          FirebaseAuth.instance.currentUser!.uid,
                          controllerCreateChat.text)
                      .whenComplete(() {
                    //_isLoading = false;
                  });*/
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Create',
                  style: TextStyle(fontFamily: 'CustomFont')),
            ),
          ],
        ),
      ),
    );
  }
}
