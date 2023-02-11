import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/screens/home/chat_1_1.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //UserModel userModel;

  TextEditingController searchName = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> searchUsers = FirebaseFirestore.instance
        .collection("app_users")
        .where('name', isEqualTo: searchName.text)
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: searchName,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                filled: false,
                border: OutlineInputBorder(),
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.white),
                suffixIcon: Icon(Icons.search)),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        body: StreamBuilder(
            stream: searchUsers,
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
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final userModelUsers = snapshot.data!;
                      final userModelThis = userModelUsers.docs[index];

                      final id = userModelThis.get('uid');
                      final name = userModelThis.get('name');
                      final email = userModelThis.get('email');
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: Text(userModelUsers.docs[index]
                              .get('name')[0]
                              .toUpperCase()),
                        ),
                        tileColor: const Color.fromARGB(255, 255, 255, 255),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        title: Text(name),
                        subtitle: Text(email),
                        onTap: () {
                          UserModel userModel = UserModel(
                            uid: userModelThis.get('uid'),
                            name: name,
                            email: email,
                            favourites: [],
                            profileImageUrl: '',
                            status: '',
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatTwoPerson(
                                      currentUser: currentUser,
                                      friendId: userModelThis.get('uid'),
                                      friendName: name)));
                        },
                      );
                    }),
              );
            }));
  }
}
