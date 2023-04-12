import 'package:snemovna/model/votes/Vote.dart';

class VoteList {
  int totalPages;
  List<Vote> content;

  VoteList({required this.totalPages, required this.content});

  VoteList.fromJson(final Map<String, dynamic> parsedJson)
      : totalPages = parsedJson['totalPages'],
        content = Vote.listFromJson(parsedJson['content']);
}
