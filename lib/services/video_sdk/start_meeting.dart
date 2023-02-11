import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/video_sdk/api.dart';
import 'package:flutter_application_1/services/video_sdk/join_screen.dart';
import 'package:flutter_application_1/services/video_sdk/meeting_screen.dart';

class StartMeeting extends StatefulWidget {
  const StartMeeting({super.key});

  @override
  State<StartMeeting> createState() => _StartMeeting();
}

class _StartMeeting extends State<StartMeeting> {
  String meetingId = "";
  bool isMeetingActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Meeting"),
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
