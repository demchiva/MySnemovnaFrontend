import 'package:flutter/cupertino.dart';
import 'package:snemovna/model/members/Member.dart';
import 'package:snemovna/model/members/MemberDetail.dart';
import 'package:snemovna/model/members/MemberVotes.dart';

@immutable
abstract class MemberState {
  const MemberState();
}

class GetMembersSuccessState extends MemberState {
  final int pageNumber;
  final bool hasReachedMax;
  final List<Member> members;

  GetMembersSuccessState({
    required this.members,
    required this.pageNumber,
    required this.hasReachedMax,
  }) : super();
}

class GetMemberDetailSuccessState extends MemberState {
  final MemberDetail memberDetail;
  GetMemberDetailSuccessState({required this.memberDetail}) : super();
}

class GetMemberVotesSuccessState extends MemberState {
  final List<MemberVotes> memberVotes;
  GetMemberVotesSuccessState({required this.memberVotes}) : super();
}

class GetMemberNotSuccessState extends MemberState {}

class MembersFirstLoading extends MemberState {}

class MembersDetailLoading extends MemberState {}
