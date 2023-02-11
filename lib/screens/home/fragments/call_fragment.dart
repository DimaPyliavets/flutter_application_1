import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/video_sdk/api.dart';
import 'package:flutter_application_1/services/video_sdk/join_screen.dart';
import 'package:flutter_application_1/services/video_sdk/meeting_screen.dart';

class CallFragment extends StatefulWidget {
  const CallFragment({Key? key}) : super(key: key);

  @override
  State<CallFragment> createState() => _CallFragmentState();
}

class _CallFragmentState extends State<CallFragment> {
  String meetingId = "";
  bool isMeetingActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.video_call,
          size: 30.0,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        title: const Text(
          'Video Meeting',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isMeetingActive
            ? MeetingScreen(
                meetingId: meetingId,
                token: token,
                leaveMeeting: () {
                  setState(() => isMeetingActive = false);
                },
              )
            : JoinScreen(
                onMeetingIdChanged: (value) => meetingId = value,
                onCreateMeetingButtonPressed: () async {
                  meetingId = await createMeeting();
                  setState(() => isMeetingActive = true);
                },
                onJoinMeetingButtonPressed: () {
                  setState(() => isMeetingActive = true);
                },
              ),
      ),
    );
  }
}
