import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snemovna/model/votes/VoteMembers.dart';
import 'package:snemovna/navigation/Navigation.dart';
import 'package:snemovna/service/VotesResultService.dart';
import 'package:snemovna/utils/BaseTools.dart';

class VoteMemberCard extends StatelessWidget {
  final VoteMembers member;

  VoteMemberCard({required this.member});

  @override
  Widget build(final BuildContext context) {
    ScreenUtil.init(context);
    final VoteResult result = getMemberVoteResult(member.result);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: setWidth(8)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5,
        child: ListTile(
          onTap: () {
            Navigation.me.memberDetail(context, member.memberId);
          },
          leading: CachedNetworkImage(
            imageUrl: member.photoUrl,
            height: setHeight(100),
            width: setWidth(50),
            errorWidget: (final context, final url, final error) =>
                const Center(
              child: Icon(Icons.account_circle),
            ),
          ),
          title: Text(
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: setSp(14),
            ),
            member.name,
          ),
          subtitle: Padding(
            padding: EdgeInsets.symmetric(vertical: setHeight(5)),
            child:
                Text(style: TextStyle(fontSize: setSp(12)), member.partyName),
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
