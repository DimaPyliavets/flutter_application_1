import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/group_model.dart';

class GroupChat extends StatefulWidget {
  GroupChat({super.key, required this.groupModel});
  GroupModel? groupModel;

  @override
  State<GroupChat> createState() => _GroupChat();
}

class _GroupChat extends State<GroupChat> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupModel!.groupName),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu_sharp))
        ],
      ),
      body: Column(children: [
        Expanded(child: Container()),
        Container(
          color: Colors.grey[200],
          child: const TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: 'enter messege ...'),
          ),
        )
      ]),
    );
  }
}
