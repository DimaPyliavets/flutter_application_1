import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendid;

  const MessageTextField(
      {super.key, required this.currentId, required this.friendid});

  @override
  _MessageTextField createState() => _MessageTextField();
}

class _MessageTextField extends State<MessageTextField> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("curr: ${widget.currentId}");
    print("fr: ${widget.friendid}");
    return Container(
      color: Colors.white,
      padding: const EdgeInsetsDirectional.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: controller,
            decoration: InputDecoration(
                label: const Text("Enter sms"),
                fillColor: Colors.grey[100],
                filled: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                  gapPadding: 10,
                )),
          )),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () async {
              String message = controller.text;

              FirebaseFirestore.instance
                  .collection('app_users')
                  .doc(widget.currentId)
                  .collection('messages')
                  .doc(widget.friendid)
                  .collection('chat')
                  .add({
                'senderId': widget.currentId,
                'receiverId': widget.friendid,
                'message': message,
                'type': 'text',
                'date': DateTime.now(),
              }).then((value) {
                FirebaseFirestore.instance
                    .collection('app_users')
                    .doc(widget.currentId)
                    .collection('messages')
                    .doc(widget.friendid)
                    .set({'last_message': message});
              });

              FirebaseFirestore.instance
                  .collection('app_users')
                  .doc(widget.friendid)
                  .collection('messages')
                  .doc(widget.currentId)
                  .collection('chat')
                  .add({
                'senderId': widget.currentId,
                'receiverId': widget.friendid,
                'message': message,
                'type': 'text',
                'date': DateTime.now(),
              }).then((value) {
                FirebaseFirestore.instance
                    .collection('app_users')
                    .doc(widget.currentId)
                    .collection('messages')
                    .doc(widget.friendid)
                    .set({'last_message': message});
              });
              controller.clear();
            },
            icon: const Icon(
              Icons.send,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
