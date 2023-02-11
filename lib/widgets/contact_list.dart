import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/widgets/contact_tile.dart';
import 'package:provider/provider.dart';

class ContactList extends StatefulWidget {
  ContactList({super.key});

  var currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<List<UserModel>>(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: userModel.length,
      itemBuilder: (context, index) {
        return ContactTile(
          userModel: userModel[index],
        );
      },
    );
  }
}
