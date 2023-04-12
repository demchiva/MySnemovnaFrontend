import 'package:flutter/cupertino.dart';
import 'package:snemovna/model/members/Member.dart';

@immutable
class MembersList {
  final int totalPages;
  final List<Member> content;

  const MembersList({required this.totalPages, required this.content});

  MembersList.fromJson(final Map<String, dynamic> parsedJson)
      : totalPages = parsedJson['totalPages'],
        content = Member.listFromJson(parsedJson['content']);
}
