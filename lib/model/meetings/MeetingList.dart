import 'package:snemovna/model/meetings/Meeting.dart';

class MeetingList {
  int totalPages;
  List<Meeting> content;

  MeetingList({required this.totalPages, required this.content});

  MeetingList.fromJson(final Map<String, dynamic> parsedJson)
      : totalPages = parsedJson['totalPages'],
        content = Meeting.listFromJson(parsedJson['content']);
}
