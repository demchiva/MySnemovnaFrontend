import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snemovna/model/members/Member.dart';
import 'package:snemovna/model/members/MemberVotes.dart';
import 'package:snemovna/screen/members/MemberCard.dart';
import 'package:snemovna/screen/members/MemberVotesCard.dart';

void main() {
  testWidgets('ItemCard displays member information',
      (final WidgetTester tester) async {
    final member = Member(
      memberId: 123,
      name: 'John Doe',
      photo: '',
      party: 'Democratic',
      region: 'California',
      dateFrom: '2022-01-01',
      dateTo: '2022-12-31',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.zero,
            child: Container(),
          ),
          body: MemberCard(member: member),
        ),
      ),
    );

    expect(find.text(member.name), findsOneWidget);
    expect(find.text(member.party!), findsOneWidget);
    expect(find.text(member.region), findsOneWidget);
    expect(
      find.text('${member.dateFrom} - ${member.dateTo ?? '...'}'),
      findsOneWidget,
    );
  });

  testWidgets('should display member vote details',
      (final WidgetTester tester) async {
    final memberVote = MemberVotes(
        name: 'John Doe', date: '2022-01-01', result: '', voteId: 1);

    await tester.pumpWidget(
      MaterialApp(
        home: MemberVotesCard(memberVote: memberVote),
      ),
    );

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('2022-01-01'), findsOneWidget);
  });
}
