import 'package:snemovna/model/members/MemberDetail.dart';
import 'package:snemovna/model/members/MemberVotes.dart';
import 'package:snemovna/model/members/MembersList.dart';
import 'package:snemovna/repository/NetworkManager.dart';

class MemberRemoteRepository {
  static const String _URL = 'https://my-snemovna.herokuapp.com/api/v1/members';
  final NetworkManager _networkManager = NetworkManager();

  Future<MembersList> getMembers(
    final int pageNumber,
    final int pageSize,
    final String? search,
  ) async {
    final response = await _networkManager.get(
      path: _URL,
      queryParameters: {
        'page': pageNumber,
        'size': pageSize,
        'property': 'id',
        'direction': 'DESC',
        'search': search
      },
    );

    return MembersList.fromJson(response.data as Map<String, dynamic>);
  }

  Future<MemberDetail> getMemberDetail(final int memberId) async {
    final response = await _networkManager.get(path: '$_URL/$memberId');
    return MemberDetail.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<MemberVotes>> getMemberVotes(final int memberId) async {
    final response = await _networkManager.get(path: '$_URL/$memberId/votes');

    final List<MemberVotes> members = [];
    for (final value in response.data) {
      members.add(MemberVotes.fromJson(value));
    }

    return members;
  }
}
