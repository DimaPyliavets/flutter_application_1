import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';

class ContactTile extends StatelessWidget {
  final UserModel userModel;
  const ContactTile({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
      child: Card(
        color: const Color.fromARGB(255, 190, 223, 253),
        margin: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(userModel.name[0].toUpperCase()),
          ),
          title: Text(userModel.name),
          subtitle: Text(userModel.email),
          onTap: () {},
        ),
      ),
    );
  }
}
