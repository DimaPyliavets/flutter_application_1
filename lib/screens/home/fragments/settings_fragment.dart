import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/database.dart';

class SettingFragment extends StatefulWidget {
  const SettingFragment({super.key});

  @override
  State<SettingFragment> createState() => _SettingFragmentState();
}

class _SettingFragmentState extends State<SettingFragment> {
  var currentUser = FirebaseAuth.instance.currentUser!.uid;
  final AuthServices _auth = AuthServices();
  //UserModel? userModel;
  final TextEditingController controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(
          Icons.blur_on_sharp,
          size: 30.0,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: DatabaseService(uid: '').readCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: Text('Loading'),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.only(top: 75.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10.0),
                  Center(
                    child: CircleAvatar(
                        radius: 50,
                        child: Text(
                          snapshot.data!.name[0].toUpperCase(),
                          style: const TextStyle(fontSize: 40.0),
                        )),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height * 0.025, 0, 0),
                      child: Text(
                        textAlign: TextAlign.left,
                        snapshot.data!.name.toString(),
                        style: const TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        textAlign: TextAlign.left,
                        snapshot.data!.email.toString(),
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.grey[400],
                  ),
                  Center(
                    child: OutlinedButton.icon(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      label: const Text(
                        'Edit data',
                        selectionColor: Colors.blue,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: ((context) {
                              return SizedBox(
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(height: 10.0),
                                    const Text(
                                      'Change data',
                                      style: TextStyle(fontSize: 25.0),
                                    ),
                                    const SizedBox(height: 30.0),
                                    TextField(
                                      controller: controllerName,
                                      decoration: const InputDecoration(
                                        labelText: 'Name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    ElevatedButton(
                                        onPressed: () {
                                          final userChangere = FirebaseFirestore
                                              .instance
                                              .collection('app_users')
                                              .doc(currentUser);

                                          userChangere.update({
                                            'name': controllerName.text,
                                          });

                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Save')),
                                  ],
                                ),
                              );
                            }));
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await _auth.signOut();
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      label: const Text(
                        'Log out',
                        selectionColor: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        //
                        await DatabaseService(uid: currentUser).deleteUser();
                        await _auth.signOut();
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      label: const Text(
                        'Delete account',
                        selectionColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }));
}
