import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snemovna/model/votes/Vote.dart';
import 'package:snemovna/model/votes/VoteMembers.dart';
import 'package:snemovna/screen/votes/VoteCard.dart';
import 'package:snemovna/screen/votes/VoteMemberCard.dart';

void main() {
  final VoteMembers testMember = VoteMembers(
    memberId: 1,
    photoUrl: '',
    name: '',
    partyName: 'Example Party',
    result: '',
  );

  testWidgets('VoteCard displays vote details correctly',
      (final WidgetTester tester) async {
    // Create a Vote object for testing
    final Vote vote = Vote(
      voteId: 1,
      name: 'Test Vote',
      result: 'some result',
      date: '2023-04-16',
      aye: 10,
      no: 5,
      abstained: 3,
    );

    // Build the VoteCard widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VoteCard(vote: vote),
        ),
      ),
    );

    // Expect to find the vote details in the widget
    expect(find.text('Test Vote'), findsOneWidget);
    expect(find.text('2023-04-16'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
    expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    expect(find.byIcon(Icons.output), findsOneWidget);
  });

  testWidgets('VoteMemberCard displays member data correctly',
      (final WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: VoteMemberCard(member: testMember),
        ),
      ),
    );
    expect(find.text('Example Party'), findsOneWidget);
  });
}
