import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:snemovna/model/members/Member.dart';
import 'package:snemovna/model/members/MemberDetail.dart';
import 'package:snemovna/model/members/MemberVotes.dart';

@immutable
abstract class MemberState extends Equatable {
  @override
  List<Object> get props => [];
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

  @override
  bool operator ==(final Object object) =>
      object is GetMembersSuccessState &&
      object.members.length == members.length &&
      object.pageNumber == pageNumber &&
      object.hasReachedMax == hasReachedMax;
}

class GetMemberDetailSuccessState extends MemberState {
  final MemberDetail memberDetail;
  GetMemberDetailSuccessState({required this.memberDetail}) : super();

  @override
  bool operator ==(final Object object) =>
      object is GetMemberDetailSuccessState;
}

class GetMemberVotesSuccessState extends MemberState {
  final List<MemberVotes> memberVotes;
  GetMemberVotesSuccessState({required this.memberVotes}) : super();

  @override
  bool operator ==(final Object object) =>
      object is GetMemberVotesSuccessState &&
      object.memberVotes.length == memberVotes.length;
}

class GetMemberNotSuccessState extends MemberState {
  @override
  bool operator ==(final Object object) => object is GetMemberNotSuccessState;
}

class MembersFirstLoading extends MemberState {
  @override
  bool operator ==(final Object object) => object is MembersFirstLoading;
}

class MembersDetailLoading extends MemberState {
  @override
  bool operator ==(final Object object) => object is MembersDetailLoading;
}
