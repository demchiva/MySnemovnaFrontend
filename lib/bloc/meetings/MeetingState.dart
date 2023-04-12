import 'package:flutter/material.dart';
import 'package:snemovna/model/meetings/Meeting.dart';
import 'package:snemovna/model/meetings/MeetingDetail.dart';

@immutable
abstract class MeetingState {
  const MeetingState();
}

class GetMeetingsSuccessState extends MeetingState {
  final int pageNumber;
  final bool hasReachedMax;
  final List<Meeting> meetings;

  GetMeetingsSuccessState({
    required this.meetings,
    required this.pageNumber,
    required this.hasReachedMax,
  }) : super();
}

class GetMeetingDetailSuccessState extends MeetingState {
  final MeetingDetail proposed;
  final MeetingDetail approved;
  GetMeetingDetailSuccessState({required this.proposed, required this.approved})
      : super();
}

class GetMeetingNotSuccessState extends MeetingState {}

class MeetingsFirstLoading extends MeetingState {}

class MeetingDetailLoading extends MeetingState {}
