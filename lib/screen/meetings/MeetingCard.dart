import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snemovna/model/meetings/Meeting.dart';
import 'package:snemovna/navigation/Navigation.dart';
import 'package:snemovna/service/MeetingService.dart';
import 'package:snemovna/utils/BaseTools.dart';

class MeetingItemCard extends StatelessWidget {
  final Meeting meeting;

  MeetingItemCard(this.meeting);

  @override
  Widget build(final BuildContext context) {
    ScreenUtil.init(context);
    final MeetingStateDisplay state = getMeetingState(meeting);

    return GestureDetector(
      onTap: () {
        Navigation.me.meetingDetail(context, meeting);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SizedBox(
            width: setWidth(80),
            height: setHeight(80),
            child: Column(
              children: [
                Text(
                  style: TextStyle(fontSize: setSp(16)),
                  meeting.meetingNumber.toString(),
                ),
                meeting.type == 'Test Type'
                    ? const Text('')
                    : Text(style: TextStyle(fontSize: setSp(16)), 'schůze'),
              ],
            ),
          ),
          isThreeLine: true,
          title: Text(meeting.date),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: setHeight(2)),
                child: Text(
                  style: TextStyle(fontSize: setSp(12)),
                  meeting.type,
                ),
              ),
              Text(
                style: TextStyle(fontSize: setSp(12)),
                meeting.organName,
              ),
            ],
          ),
          trailing: Padding(
            padding: EdgeInsets.only(right: setWidth(5)),
            child: Container(
              width: setWidth(80),
              height: setHeight(50),
              color: state.color,
              child: Padding(
                padding: EdgeInsets.all(setWidth(8)),
                child: Center(child: Text(state.text)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
