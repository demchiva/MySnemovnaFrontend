import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snemovna/model/members/MemberVotes.dart';
import 'package:snemovna/navigation/Navigation.dart';
import 'package:snemovna/service/VotesResultService.dart';
import 'package:snemovna/utils/BaseTools.dart';

class MemberVotesCard extends StatelessWidget {
  final MemberVotes memberVote;

  MemberVotesCard({required this.memberVote});

  @override
  Widget build(final BuildContext context) {
    ScreenUtil.init(context);
    VoteResult result = getMemberVoteResult(memberVote.result);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: setWidth(8)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5,
        child: ListTile(
          onTap: () {
            Navigation.me.voteDetail(context, memberVote.voteId);
          },
          title: Text(memberVote.name),
          subtitle: Padding(
            padding: EdgeInsets.symmetric(vertical: setHeight(5)),
            child: Text(memberVote.date),
          ),
          trailing: Container(
            width: setWidth(100),
            color: result.color,
            child: Padding(
              padding: EdgeInsets.all(setWidth(8)),
              child: Center(child: Text(result.text)),
            ),
          ),
        ),
      ),
    );
  }
}
