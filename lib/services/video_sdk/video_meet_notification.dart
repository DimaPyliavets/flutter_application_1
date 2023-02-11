import 'package:flutter/widgets.dart';

class VideoMeetingNotification extends Notification {
  VideoMeetingNotification({required this.roomId, required this.token});

  final String roomId;
  final String token;
}
