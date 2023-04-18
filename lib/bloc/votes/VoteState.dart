import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:snemovna/model/votes/Vote.dart';
import 'package:snemovna/model/votes/VoteDetail.dart';
import 'package:snemovna/model/votes/VoteMembers.dart';

@immutable
abstract class VoteState extends Equatable {
  @override
  List<Object> get props => [];

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

  @override
  bool operator ==(final Object object) =>
      object is GetVotesSuccessState &&
      object.votes.length == votes.length &&
      object.pageNumber == pageNumber &&
      object.hasReachedMax == hasReachedMax;
}

class GetVoteDetailSuccessState extends VoteState {
  final VoteDetail voteDetail;
  GetVoteDetailSuccessState({required this.voteDetail}) : super();

  @override
  bool operator ==(final Object object) => object is GetVoteDetailSuccessState;
}

class GetVoteMembersSuccessState extends VoteState {
  final List<VoteMembers> voteMembers;
  GetVoteMembersSuccessState({required this.voteMembers}) : super();

  @override
  bool operator ==(final Object object) =>
      object is GetVoteMembersSuccessState &&
      object.voteMembers.length == voteMembers.length;
}

class GetVoteNotSuccessState extends VoteState {}

class VotesFirstLoading extends VoteState {
  @override
  bool operator ==(final Object object) => object is VotesFirstLoading;
}

class VoteDetailLoading extends VoteState {
  @override
  bool operator ==(final Object object) => object is VoteDetailLoading;
}
