import 'package:flutter_test/flutter_test.dart';
import 'package:snemovna/model/meetings/MeetingDetail.dart';
import 'package:snemovna/model/meetings/MeetingList.dart';

void main() {
  test('MeetingList parsing test', () {
    const json = {
      'totalPages': 10,
      'content': [
        {
          'meetingId': 726,
          'meetingNumber': 64,
          'date': '2023-04-19 15:00',
          'type': 'Mimořádná',
          'organName': 'PSP9',
          'dateFrom': '2023-04-19T15:00:00'
        }
      ]
    };
    final meetingList = MeetingList.fromJson(json);
    expect(meetingList.totalPages, 10);
    expect(meetingList.content.length, 1);
    expect(meetingList.content.first.meetingId, 726);
    expect(meetingList.content.first.meetingNumber, 64);
    expect(meetingList.content.first.date, '2023-04-19 15:00');
    expect(meetingList.content.first.type, 'Mimořádná');
    expect(meetingList.content.first.organName, 'PSP9');
    expect(meetingList.content.first.dateFrom, '2023-04-19T15:00:00');
    expect(meetingList.content.first.state, null);
    expect(meetingList.content.first.dateTo, null);
  });

  test('MeetingDetail parsing test', () {
    const json = {
      'meetingPoints': [
        {
          'name': 'some name',
          'state': 'some state',
          'type': 'some type',
        }
      ]
    };
    final meetingDetail = MeetingDetail.fromJson(json);
    expect(meetingDetail.points.length, 1);
    expect(meetingDetail.points.first.name, 'some name');
    expect(meetingDetail.points.first.state, 'some state');
    expect(meetingDetail.points.first.type, 'some type');
  });
}
