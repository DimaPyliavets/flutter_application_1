import 'package:flutter/material.dart';

class MeetingControls extends StatefulWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleCameraButtonPressed;
  final void Function() onLeaveButtonPressed;
  final void Function() onToggleCameraChangeButtonPressed;

  const MeetingControls({
    Key? key,
    required this.onToggleMicButtonPressed,
    required this.onToggleCameraButtonPressed,
    required this.onLeaveButtonPressed,
    required this.onToggleCameraChangeButtonPressed,
  }) : super(key: key);

  @override
  State<MeetingControls> createState() => _MeetingControlsState();
}

class _MeetingControlsState extends State<MeetingControls> {
  bool micEnabled = true;
  bool camEnabled = true;

  @override
  void initState() {
    super.initState();
    micEnabled = true;
    camEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: widget.onLeaveButtonPressed,
            child: const Icon(Icons.exit_to_app),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            child:
                micEnabled ? const Icon(Icons.mic) : const Icon(Icons.mic_off),
            onPressed: () {
              widget.onToggleMicButtonPressed();
              setState(() {
                micEnabled = !micEnabled;
              });
            },
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            child: camEnabled
                ? const Icon(Icons.camera_alt_rounded)
                : const Icon(Icons.camera_alt_outlined),
            onPressed: () {
              widget.onToggleCameraButtonPressed();
              setState(() {
                camEnabled = !camEnabled;
              });
            },
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: widget.onToggleCameraChangeButtonPressed,
            child: const Icon(Icons.camera_front),
          )
        ],
      ),
    );
  }
}
