import 'package:flutter/material.dart';
import 'package:snemovna/model/meetings/Meeting.dart';
import 'package:snemovna/screen/HomeScreen.dart';
import 'package:snemovna/screen/meetings/MeetingDetailScreen.dart';
import 'package:snemovna/screen/members/MemberDetailScreen.dart';
import 'package:snemovna/screen/votes/VoteDetailScreen.dart';

class Navigation {
  static const String MAIN_ROUTE_NAME = '/';

  static final Navigation me = Navigation._();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Navigation._();

  Future<dynamic> navigateTo(
    final BuildContext context,
    final String routeName,
    final Object? args,
  ) =>
      Navigator.pushNamed(context, routeName, arguments: args);

  Future<void> voteDetail(final BuildContext context, final int voteId) =>
      Navigator.of(context)
          .pushNamed(VoteDetailScreen.ROUTE_NAME, arguments: voteId);

  Future<void> memberDetail(final BuildContext context, final int memberId) =>
      Navigator.of(context)
          .pushNamed(MemberDetailScreen.ROUTE_NAME, arguments: memberId);

  Future<void> meetingDetail(
    final BuildContext context,
    final Meeting meeting,
  ) =>
      Navigator.of(context)
          .pushNamed(MeetingDetailScreen.ROUTE_NAME, arguments: meeting);

  void pop(final BuildContext context) {
    Navigator.of(context).pop();
  }

  void popUntil(final BuildContext context, final String route) {
    Navigator.of(context).popUntil(ModalRoute.withName(route));
  }

  Map<String, WidgetBuilder> routeList() => {
        VoteDetailScreen.ROUTE_NAME: (final BuildContext context) =>
            const VoteDetailScreen(),
        MemberDetailScreen.ROUTE_NAME: (final BuildContext context) =>
            const MemberDetailScreen(),
        MeetingDetailScreen.ROUTE_NAME: (final BuildContext context) =>
            const MeetingDetailScreen()
      };

  Route<dynamic> onGenerateRoute(final RouteSettings routeSettings) =>
      MaterialPageRoute(
        builder: (final BuildContext context) => const HomeScreen(barIndex: 0),
        settings: routeSettings,
      );
}
