import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snemovna/model/meetings/MeetingDetail.dart';
import 'package:snemovna/utils/BaseTools.dart';

class MeetingPointCard extends StatelessWidget {
  final MeetingPoint point;
  final TabController tabController;

  MeetingPointCard({required this.point, required this.tabController});

  @override
  Widget build(final BuildContext context) {
    ScreenUtil.init(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 5,
      child: ListTile(
        // isThreeLine: true,
        title: Text(point.name),
        subtitle: (point.type != null ||
                (point.state != null && tabController.index == 1))
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (point.type != null)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: setHeight(5)),
                      child: Text(
                        '${point.type}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  if (point.state != null && tabController.index == 1)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: setHeight(5)),
                      child: SizedBox(
                        width: setWidth(100),
                        child: Text(
                          point.state!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              )
            : null,
      ),
    );
  }
}
