import 'package:flutter/material.dart';

@immutable
abstract class MeetingEvent {
  const MeetingEvent();
}

class GetMeetings extends MeetingEvent {
  final int pageNumber;
  GetMeetings({required this.pageNumber}) : super();
}

class GetMeetingDetail extends MeetingEvent {
  final int meetingId;
  GetMeetingDetail({required this.meetingId}) : super();
}
