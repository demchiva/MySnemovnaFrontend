import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:snemovna/model/meetings/Meeting.dart';
import 'package:snemovna/model/meetings/MeetingDetail.dart';

@immutable
abstract class MeetingState extends Equatable {
  @override
  List<Object> get props => [];
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

  @override
  bool operator ==(final Object object) =>
      object is GetMeetingsSuccessState &&
      object.meetings.length == meetings.length &&
      object.pageNumber == pageNumber &&
      object.hasReachedMax == hasReachedMax;
}

class GetMeetingDetailSuccessState extends MeetingState {
  final MeetingDetail proposed;
  final MeetingDetail approved;
  GetMeetingDetailSuccessState({required this.proposed, required this.approved})
      : super();

  @override
  bool operator ==(final Object object) =>
      object is GetMeetingDetailSuccessState;
}

class GetMeetingNotSuccessState extends MeetingState {
  @override
  bool operator ==(final Object object) => object is GetMeetingNotSuccessState;
}

class MeetingsFirstLoading extends MeetingState {
  @override
  bool operator ==(final Object object) => object is MeetingsFirstLoading;
}

class MeetingDetailLoading extends MeetingState {
  @override
  bool operator ==(final Object object) => object is MeetingDetailLoading;
}
