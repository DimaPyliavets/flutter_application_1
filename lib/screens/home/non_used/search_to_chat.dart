import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/group_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/screens/home/non_used/group_chat.dart';

class SearchChatScreen extends StatefulWidget {
  const SearchChatScreen({super.key});

  @override
  State<SearchChatScreen> createState() => _SearchChatScreen();
}

class _SearchChatScreen extends State<SearchChatScreen> {
  UserModel? userModel;

  TextEditingController searchNameOfChat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> searchGroups = FirebaseFirestore.instance
        .collection("app_chat4")
        .where('groupName', isEqualTo: searchNameOfChat.text)
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: searchNameOfChat,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                filled: false,
                border: OutlineInputBorder(),
                hintText: "Search group...",
                hintStyle: TextStyle(color: Colors.white),
                suffixIcon: Icon(Icons.search)),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        body: StreamBuilder(
            stream: searchGroups,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            child: Text(
                                data['groupName'].toString().toUpperCase()[0]),
                          ),
                          title: Text(data['groupName']),
                          subtitle: Text(data['admin']),
                          trailing: IconButton(
                            icon: const Icon(Icons.add_box),
                            onPressed: () {
                              GroupModel groupModel = GroupModel(
                                  groupName: data['groupName'],
                                  groupIcon: '',
                                  admin: data['admin'],
                                  groupId: '',
                                  recentMessege: data['recenMessege'],
                                  recentMessegeSender: '',
                                  members: []);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GroupChat(groupModel: groupModel)));
                            },
                          ));
                    }).toList(),
                  ));
            }));
  }
}
