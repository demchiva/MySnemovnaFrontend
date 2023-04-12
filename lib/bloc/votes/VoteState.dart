import 'package:flutter/cupertino.dart';
import 'package:snemovna/model/votes/Vote.dart';
import 'package:snemovna/model/votes/VoteDetail.dart';
import 'package:snemovna/model/votes/VoteMembers.dart';

@immutable
abstract class VoteState {
  const VoteState();
}

class GetVotesSuccessState extends VoteState {
  final int pageNumber;
  final bool hasReachedMax;
  final List<Vote> votes;

  GetVotesSuccessState({
    required this.votes,
    required this.pageNumber,
    required this.hasReachedMax,
  }) : super();
}

class GetVoteDetailSuccessState extends VoteState {
  final VoteDetail voteDetail;
  GetVoteDetailSuccessState({required this.voteDetail}) : super();
}

class GetVoteMembersSuccessState extends VoteState {
  final List<VoteMembers> voteMembers;
  GetVoteMembersSuccessState({required this.voteMembers}) : super();
}

class GetVoteNotSuccessState extends VoteState {}

class VotesFirstLoading extends VoteState {}

class VoteDetailLoading extends VoteState {}
