import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:videosdk/videosdk.dart';
import 'meeting_controls.dart';
import 'participant_tile.dart';

class MeetingScreen extends StatefulWidget {
  final String meetingId;
  final String token;
  final void Function() leaveMeeting;

  const MeetingScreen(
      {Key? key,
      required this.meetingId,
      required this.token,
      required this.leaveMeeting})
      : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  Map<String, Stream?> participantVideoStreams = {};

  bool micEnabled = true;
  bool camEnabled = true;
  late Room room;
  int cameraIndex = 0;

  void setParticipantStreamEvents(Participant participant) {
    participant.on(Events.streamEnabled, (Stream stream) {
      if (stream.kind == 'video') {
        setState(() => participantVideoStreams[participant.id] = stream);
      }
    });

    participant.on(Events.streamDisabled, (Stream stream) {
      if (stream.kind == 'video') {
        setState(() => participantVideoStreams.remove(participant.id));
      }
    });
  }

  void setMeetingEventListener(Room _room) {
    setParticipantStreamEvents(_room.localParticipant);
    _room.on(
      Events.participantJoined,
      (Participant participant) => setParticipantStreamEvents(participant),
    );
    _room.on(Events.participantLeft, (String participantId) {
      if (participantVideoStreams.containsKey(participantId)) {
        setState(() => participantVideoStreams.remove(participantId));
      }
    });
    _room.on(Events.roomLeft, () {
      participantVideoStreams.clear();
      widget.leaveMeeting();
    });
  }

  @override
  void initState() {
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([]);
    room = VideoSDK.createRoom(
      roomId: widget.meetingId,
      token: widget.token,
      displayName: " ",
      micEnabled: micEnabled,
      camEnabled: camEnabled,
      maxResolution: 'sd',
      defaultCameraIndex: cameraIndex,
    );

    setMeetingEventListener(room);
    room.join();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(children: [
            Text("Meeting ID: ${room.id}"),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                final String roomId = room.id;
                Clipboard.setData(ClipboardData(text: roomId));
              },
            ),
          ]),
          const SizedBox(height: 5),
          SizedBox(
            width: 400,
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView(
              children: participantVideoStreams.values
                  .map(
                    (e) => ParticipantTile(
                      stream: e!,
                    ),
                  )
                  .toList(),
            ),
          ),
          MeetingControls(
            onToggleMicButtonPressed: () {
              micEnabled ? room.muteMic() : room.unmuteMic();
              micEnabled = !micEnabled;
            },
            onToggleCameraButtonPressed: () {
              camEnabled ? room.disableCam() : room.enableCam();
              camEnabled = !camEnabled;
            },
            onLeaveButtonPressed: () => room.leave(),
            onToggleCameraChangeButtonPressed: () {
              if (cameraIndex == 0) {
                room.changeCam((cameraIndex = 1).toString());
              } else if (cameraIndex == 1) {
                room.changeCam((cameraIndex = 0).toString());
              }
            },
          ),
        ],
      ),
    );
  }
}
