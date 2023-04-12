import 'package:flutter/material.dart';

@immutable
abstract class MemberEvent {
  const MemberEvent();
}

class GetMembers extends MemberEvent {
  final int pageNumber;
  final String? search;
  GetMembers({required this.pageNumber, this.search}) : super();
}

class GetMemberDetail extends MemberEvent {
  final int memberId;
  GetMemberDetail({required this.memberId}) : super();
}

class GetVotes extends MemberEvent {
  final int memberId;
  GetVotes({required this.memberId}) : super();
}
