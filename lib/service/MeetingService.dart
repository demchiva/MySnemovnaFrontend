import 'package:flutter/material.dart';
import 'package:snemovna/model/meetings/Meeting.dart';

MeetingStateDisplay getMeetingState(final Meeting meeting) =>
    meeting.state != null
        ? MeetingStateDisplay(meeting.state!, Colors.yellow)
        : DateTime.parse(meeting.dateFrom).isBefore(DateTime.now())
            ? MeetingStateDisplay('Ukončená.', Colors.grey)
            : MeetingStateDisplay('Svolaná.', Colors.lightGreen);

@immutable
class MeetingStateDisplay {
  final String text;
  final Color color;

  MeetingStateDisplay(this.text, this.color);
}
