import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';

class MyInformation extends StatelessWidget {
  MyInformation({super.key});

  final controllerName = TextEditingController();

  var currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      FutureBuilder<UserModel?>(
        //future: DatabaseService(uid: '').readCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (snapshot.hasData) {
            final myUser = snapshot.data;
            if (myUser == null) {
              return const Center(child: Text('No user'));
            } else {
              return Card(
                  //child: build(myUser)
                  );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ]));
  }
}
