import 'package:snemovna/model/meetings/MeetingDetail.dart';
import 'package:snemovna/model/meetings/MeetingList.dart';
import 'package:snemovna/repository/meetings/MeetingsRemoteRepository.dart';

class MockMeetingRemoteRepository implements MeetingRemoteRepository {
  @override
  Future<MeetingDetail> getMeetingDetail(
    final int meetingId,
    final String agendaType,
  ) async =>
      MeetingDetail(points: []);

  @override
  Future<MeetingList> getMeetings(
    final int pageNumber,
    final int pageSize,
  ) async =>
      MeetingList(totalPages: 10, content: []);
}
