import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snemovna/model/meetings/Meeting.dart';
import 'package:snemovna/model/meetings/MeetingDetail.dart';
import 'package:snemovna/screen/meetings/MeetingCard.dart';
import 'package:snemovna/screen/meetings/MeetingPointCard.dart';

import '../mocks/AnimatedMockTicker.dart';

void main() {
  final MeetingPoint mockMeetingPoint = MeetingPoint(
    name: 'Test Meeting Point',
    type: 'Test Type',
    state: '',
  );
  final TabController mockTabController = TabController(
    length: 2,
    vsync: AnimatedMockTicker(),
  );

  testWidgets('MeetingPointCard displays meeting point information correctly',
      (final WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MeetingPointCard(
          point: mockMeetingPoint,
          tabController: mockTabController,
        ),
      ),
    );

    expect(find.text('Test Meeting Point'), findsOneWidget);
    expect(find.text('Test Type'), findsOneWidget);
  });

  testWidgets('MeetingItemCard displays meeting information correctly',
      (final WidgetTester tester) async {
    // Set up a test meeting
    final Meeting testMeeting = Meeting(
      meetingNumber: 1,
      date: '2022-04-20',
      type: 'Test Type',
      organName: 'Test Organ Name',
      meetingId: 1,
      state: '',
      dateFrom: '',
      dateTo: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MeetingItemCard(testMeeting),
        ),
      ),
    );

    expect(find.text('1'), findsOneWidget);
    expect(find.text('schůze'), findsNothing);
    expect(find.text('2022-04-20'), findsOneWidget);
    expect(find.text('Test Type'), findsOneWidget);
    expect(find.text('Test Organ Name'), findsOneWidget);
  });
}
