import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snemovna/model/members/Member.dart';
import 'package:snemovna/navigation/Navigation.dart';
import 'package:snemovna/utils/BaseTools.dart';

class MemberCard extends StatelessWidget {
  final Member member;

  const MemberCard({required this.member, final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    ScreenUtil.init(context);
    return GestureDetector(
      onTap: () {
        Navigation.me.memberDetail(context, member.memberId);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5,
        child: ListTile(
          leading: member.photo.isEmpty
              ? null
              : CachedNetworkImage(
                  imageUrl: member.photo,
                  height: setHeight(100),
                  width: setWidth(50),
                  errorWidget: (final context, final url, final error) =>
                      const Center(
                    child: Icon(
                      Icons.account_circle,
                      size: 50,
                    ),
                  ),
                ),
          visualDensity: const VisualDensity(
            vertical: 3,
            horizontal: 3,
          ),
          isThreeLine: true,
          title: Text(
            member.name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: setSp(14),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member.party!,
                style: TextStyle(fontSize: setSp(12)),
              ),
              Padding(
                padding: EdgeInsets.only(top: setHeight(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      member.region,
                      style: TextStyle(fontSize: setSp(10)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: setWidth(5)),
                      child: Text(
                        '${member.dateFrom} - ${member.dateTo ?? '...'}',
                        style: TextStyle(fontSize: setSp(10)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
