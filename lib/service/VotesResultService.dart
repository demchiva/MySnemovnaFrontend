import 'package:flutter/material.dart';

const String POSITIVE_MEMBER_VOTE = 'A';
const String NEGATIVE_MEMBER_VOTE_1 = 'B';
const String NEGATIVE_MEMBER_VOTE_2 = 'N';
const String ABSTAINED_MEMBER_VOTE = 'C';
const String LOGGED_IN_BUT_NOT_VOTED_MEMBER_VOTE = 'F';
const String NOT_LOGGED_IN_MEMBER_VOTE = '@';
const String EXCUSED_MEMBER_VOTE = 'M';
const String VOTE_BEFORE_PROMISE_MEMBER_VOTE = 'W';
const String ABSTAINED_OR_NOT_VOTED_MEMBER_VOTE = 'K';

final Map<String, VoteResult> _voteMemberResult = {
  POSITIVE_MEMBER_VOTE: VoteResult('Ano', Colors.green),
  NEGATIVE_MEMBER_VOTE_1: VoteResult('Ne', Colors.red),
  NEGATIVE_MEMBER_VOTE_2: VoteResult('Ne', Colors.red),
  ABSTAINED_MEMBER_VOTE: VoteResult('Zdržel/a se', Colors.grey),
  LOGGED_IN_BUT_NOT_VOTED_MEMBER_VOTE: VoteResult('Nehlasoval/a', Colors.grey),
  NOT_LOGGED_IN_MEMBER_VOTE: VoteResult('Nepřihlášen/a', Colors.grey),
  EXCUSED_MEMBER_VOTE: VoteResult('Omluven/a', Colors.grey),
  ABSTAINED_OR_NOT_VOTED_MEMBER_VOTE: VoteResult('Zdržel/a se', Colors.grey),
  VOTE_BEFORE_PROMISE_MEMBER_VOTE: VoteResult('Nepřihlášen/a', Colors.grey),
};

VoteResult getMemberVoteResult(final String key) =>
    _voteMemberResult[key] ?? VoteResult('Zdržel se/a', Colors.grey);

const String VOTE_RESULT_ACCEPTED = 'A';
const String VOTE_RESULT_DECLINED = 'R';

final Map<String, VoteResult> _voteResult = {
  VOTE_RESULT_ACCEPTED: VoteResult('Přijato', Colors.green),
  VOTE_RESULT_DECLINED: VoteResult('Zamítnuto', Colors.red),
};

VoteResult getVoteResult(final String key) =>
    _voteResult[key] ?? VoteResult('Zmatečné', Colors.grey);

@immutable
class VoteResult {
  final String text;
  final Color color;

  VoteResult(this.text, this.color);
}
