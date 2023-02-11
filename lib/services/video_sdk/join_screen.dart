import 'package:flutter/material.dart';

class JoinScreen extends StatefulWidget {
  final void Function() onCreateMeetingButtonPressed;
  final void Function() onJoinMeetingButtonPressed;
  final void Function(String) onMeetingIdChanged;

  const JoinScreen({
    Key? key,
    required this.onCreateMeetingButtonPressed,
    required this.onJoinMeetingButtonPressed,
    required this.onMeetingIdChanged,
  }) : super(key: key);

  @override
  _JoinScreenState createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  bool _isJoinButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
              backgroundColor: Colors.blue,
              label:
                  const Text("Create Meeting", style: TextStyle(fontSize: 20)),
              icon: const Icon(Icons.add),
              onPressed: widget.onCreateMeetingButtonPressed),
          const SizedBox(height: 50),
          const Text("or", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 50),
          TextField(
              decoration: const InputDecoration(
                hintText: "Meeting ID",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _isJoinButtonEnabled = value.isNotEmpty;
                });
                widget.onMeetingIdChanged(value);
              }),
          const SizedBox(height: 20),
          FloatingActionButton.extended(
            backgroundColor: _isJoinButtonEnabled
                ? Colors.blue
                : Theme.of(context).disabledColor,
            label: const Text("Join", style: TextStyle(fontSize: 20)),
            icon: const Icon(Icons.control_point),
            onPressed:
                _isJoinButtonEnabled ? widget.onJoinMeetingButtonPressed : null,
          )
        ],
      ),
    );
  }
}
