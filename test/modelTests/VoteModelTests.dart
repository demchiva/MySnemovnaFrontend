import 'package:flutter_test/flutter_test.dart';
import 'package:snemovna/model/votes/Vote.dart';
import 'package:snemovna/model/votes/VoteDetail.dart';
import 'package:snemovna/model/votes/VoteList.dart';

void main() {
  group('VoteList.fromJson', () {
    test('should parse valid JSON correctly', () {
      final Map<String, dynamic> json = {
        'totalPages': 2,
        'content': [
          {
            'voteId': 1,
            'result': 'Passed',
            'name': 'Vote 1',
            'aye': 10,
            'no': 5,
            'abstained': 2,
            'date': '2023-04-15',
          },
          {
            'voteId': 2,
            'result': 'Failed',
            'name': 'Vote 2',
            'aye': 5,
            'no': 10,
            'abstained': 3,
            'date': '2023-04-14',
          },
        ],
      };

      final voteList = VoteList.fromJson(json);

      expect(voteList.totalPages, 2);
      expect(voteList.content.length, 2);
      expect(voteList.content[0].voteId, 1);
      expect(voteList.content[0].result, 'Passed');
      expect(voteList.content[0].name, 'Vote 1');
      expect(voteList.content[0].aye, 10);
      expect(voteList.content[0].no, 5);
      expect(voteList.content[0].abstained, 2);
      expect(voteList.content[0].date, '2023-04-15');

      expect(voteList.content[1].voteId, 2);
      expect(voteList.content[1].result, 'Failed');
      expect(voteList.content[1].name, 'Vote 2');
      expect(voteList.content[1].aye, 5);
      expect(voteList.content[1].no, 10);
      expect(voteList.content[1].abstained, 3);
      expect(voteList.content[1].date, '2023-04-14');
    });
  });

  group('Vote.fromJson', () {
    test('should parse valid JSON correctly', () {
      final Map<String, dynamic> json = {
        'voteId': 1,
        'result': 'Passed',
        'name': 'Vote 1',
        'aye': 10,
        'no': 5,
        'abstained': 2,
        'date': '2023-04-15',
      };

      final vote = Vote.fromJson(json);

      expect(vote.voteId, 1);
      expect(vote.result, 'Passed');
      expect(vote.name, 'Vote 1');
      expect(vote.aye, 10);
      expect(vote.no, 5);
      expect(vote.abstained, 2);
      expect(vote.date, '2023-04-15');
    });
  });

  group('VoteDetail.fromJson', () {
    test('should parse valid JSON correctly', () {
      final Map<String, dynamic> json = {
        'voteId': 1,
        'result': 'Passed',
        'aye': 10,
        'no': 5,
        'abstained': 2,
        'date': '2023-04-15',
        'voteNumber': 123,
        'pointNumber': 456,
        'quorum': 50,
        'psUrl': 'https://example.com/vote/1',
        'longName': 'Vote Detail 1',
        'pointName': 'Point 1',
        'pointState': 'Active',
        'pointType': 'Regular',
        'meetingNumber': 789,
      };

      final voteDetail = VoteDetail.fromJson(json);

      expect(voteDetail.voteId, 1);
      expect(voteDetail.result, 'Passed');
      expect(voteDetail.aye, 10);
      expect(voteDetail.no, 5);
      expect(voteDetail.abstained, 2);
      expect(voteDetail.date, '2023-04-15');
      expect(voteDetail.voteNumber, 123);
      expect(voteDetail.pointNumber, 456);
      expect(voteDetail.quorum, 50);
      expect(voteDetail.psUrl, 'https://example.com/vote/1');
      expect(voteDetail.longName, 'Vote Detail 1');
      expect(voteDetail.pointName, 'Point 1');
      expect(voteDetail.pointState, 'Active');
      expect(voteDetail.pointType, 'Regular');
      expect(voteDetail.meetingNumber, 789);
    });
  });
}
