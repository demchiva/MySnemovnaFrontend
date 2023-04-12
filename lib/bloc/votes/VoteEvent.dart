import 'package:flutter/material.dart';

@immutable
abstract class VoteEvent {
  const VoteEvent();
}

class GetVotes extends VoteEvent {
  final int pageNumber;
  GetVotes({required this.pageNumber}) : super();
}

class GetVoteDetail extends VoteEvent {
  final int voteId;
  GetVoteDetail({required this.voteId}) : super();
}

class GetMembers extends VoteEvent {
  final int voteId;
  GetMembers({required this.voteId}) : super();
}
