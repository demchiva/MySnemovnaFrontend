import 'package:snemovna/model/meetings/MeetingDetail.dart';
import 'package:snemovna/model/meetings/MeetingList.dart';
import 'package:snemovna/repository/NetworkManager.dart';

class MeetingRemoteRepository {
  static const String _URL =
      'https://my-snemovna.herokuapp.com/api/v1/meetings';
  final NetworkManager _networkManager = NetworkManager();

  Future<MeetingList> getMeetings(
    final int pageNumber,
    final int pageSize,
  ) async {
    final response = await _networkManager.get(
      path: _URL,
      queryParameters: {
        'page': pageNumber,
        'size': pageSize,
        'property': 'id',
        'direction': 'DESC'
      },
    );

    return MeetingList.fromJson(response.data as Map<String, dynamic>);
  }

  Future<MeetingDetail> getMeetingDetail(
    final int meetingId,
    final String agendaType,
  ) async {
    final response = await _networkManager.get(
      path: '$_URL/$meetingId',
      queryParameters: {'type': agendaType},
    );

    return MeetingDetail.fromJson(response.data as Map<String, dynamic>);
  }
}
