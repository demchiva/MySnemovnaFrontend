import 'package:snemovna/model/votes/VoteDetail.dart';
import 'package:snemovna/model/votes/VoteList.dart';
import 'package:snemovna/model/votes/VoteMembers.dart';
import 'package:snemovna/repository/NetworkManager.dart';

class VoteRemoteRepository {
  static const String _URL = 'https://my-snemovna.herokuapp.com/api/v1/votes';
  final NetworkManager _networkManager = NetworkManager();

  Future<VoteList> getVotes(final int pageNumber, final int pageSize) async {
    final response = await _networkManager.get(
      path: _URL,
      queryParameters: {
        'page': pageNumber,
        'size': pageSize,
        'property': 'id',
        'direction': 'DESC'
      },
    );

    return VoteList.fromJson(response.data as Map<String, dynamic>);
  }

  Future<VoteDetail> getVoteDetail(final int voteId) async {
    final response = await _networkManager.get(path: '$_URL/$voteId');
    return VoteDetail.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<VoteMembers>> getVoteMembers(final int voteId) async {
    final response = await _networkManager.get(path: '$_URL/$voteId/members');

    final List<VoteMembers> members = [];
    for (final value in response.data) {
      members.add(VoteMembers.fromJson(value));
    }

    return members;
  }
}
