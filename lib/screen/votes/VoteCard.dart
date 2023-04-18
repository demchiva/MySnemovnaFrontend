import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snemovna/model/votes/Vote.dart';
import 'package:snemovna/navigation/Navigation.dart';
import 'package:snemovna/service/VotesResultService.dart';
import 'package:snemovna/utils/BaseTools.dart';

class VoteCard extends StatelessWidget {
  final Vote vote;

  const VoteCard({required this.vote});

  @override
  Widget build(final BuildContext context) {
    ScreenUtil.init(context);
    final VoteResult voteResult = getVoteResult(vote.result);
    return GestureDetector(
      onTap: () {
        Navigation.me.voteDetail(context, vote.voteId);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(setHeight(8)),
              child: Text(vote.name, style: TextStyle(fontSize: setSp(14))),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: setWidth(8),
                right: setWidth(24),
                bottom: setHeight(8),
              ),
              child: Text(vote.date, style: TextStyle(fontSize: setSp(11))),
            ),
            Row(
              children: <Widget>[
                Container(
                  color: voteResult.color,
                  width: setWidth(80),
                  child: Padding(
                    padding: EdgeInsets.all(setWidth(8)),
                    child: Center(child: Text(voteResult.text)),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: setWidth(24)),
                  child: Row(
                    children: <Widget>[
                      _buildTextWithIcon(
                        vote.aye.toString(),
                        Icons.arrow_upward,
                        Colors.green,
                      ),
                      _buildTextWithIcon(
                        vote.no.toString(),
                        Icons.arrow_downward,
                        Colors.red,
                      ),
                      _buildTextWithIcon(
                        vote.abstained.toString(),
                        Icons.output,
                        Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextWithIcon(
    final String text,
    final IconData icon,
    final Color iconColor,
  ) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: setWidth(3)),
        child: Row(
          children: [
            Text(style: TextStyle(fontSize: setSp(11)), text),
            const SizedBox(width: 2),
            Icon(
              icon,
              color: iconColor,
            )
          ],
        ),
      );
}
