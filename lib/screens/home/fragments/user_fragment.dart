import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/screens/home/chat_1_1.dart';
import 'package:flutter_application_1/screens/home/search.dart';
import 'package:flutter_application_1/services/database.dart';

class UserListFragment extends StatefulWidget {
  const UserListFragment({Key? key}) : super(key: key);

  @override
  State<UserListFragment> createState() => _UserListFragmentState();
}

class _UserListFragmentState extends State<UserListFragment> {
  var currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.star,
            size: 30.0,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          title: const Text('People'),
          centerTitle: true,
        ),
        floatingActionButton: buildSearcActionButton(),
        body: Column(children: [
          Expanded(
              child: StreamBuilder<List<UserModel>>(
                  stream: DatabaseService(uid: '').readUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something went wrong'),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: Text("Loading"),
                      );
                    } else if (snapshot.hasData) {
                      final userModelUsers = snapshot.data!;
                      return ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: userModelUsers.length,
                        itemBuilder: (context, index) {
                          return buildUserList(userModelUsers[index]);
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }))
        ]));
  }

  Widget buildUserList(UserModel userModel) => ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey,
          child: Text(userModel.name[0].toUpperCase()),
        ),
        tileColor: const Color.fromARGB(255, 255, 255, 255),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        title: Text(userModel.name),
        subtitle: Text(userModel.email),
        trailing: InkWell(
          child: const Icon(Icons.chat_bubble),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatTwoPerson(
                          currentUser: currentUser,
                          friendId: userModel.uid,
                          friendName: userModel.name,
                        )));
          },
        ),
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: ((context) {
                return Form(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 15.0),
                        const Text(
                          'info',
                          style: TextStyle(fontSize: 25.0),
                        ),
                        const SizedBox(height: 15.0),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            userModel.name[0].toUpperCase(),
                            style: const TextStyle(fontSize: 25.0),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Text(
                          "name : ${userModel.name}",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          "email : ${userModel.email}",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                );
              }));
        },
      );

  Widget buildSearcActionButton() => FloatingActionButton(
      child: const Icon(Icons.search_rounded),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchScreen()));
      });
}
