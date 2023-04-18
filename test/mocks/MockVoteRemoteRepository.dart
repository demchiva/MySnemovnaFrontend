import 'package:snemovna/model/votes/VoteDetail.dart';
import 'package:snemovna/model/votes/VoteList.dart';
import 'package:snemovna/model/votes/VoteMembers.dart';
import 'package:snemovna/repository/votes/VotesRemoteRepository.dart';

class MockVoteRemoteRepository implements VoteRemoteRepository {
  @override
  Future<VoteDetail> getVoteDetail(final int voteId) async => VoteDetail(
        voteId: 1,
        result: '',
        aye: 0,
        no: 0,
        abstained: 0,
        date: '2023-04-19 15:00',
        voteNumber: 0,
        pointNumber: 0,
        quorum: 0,
        psUrl: '',
        longName: '',
        pointName: '',
        pointState: null,
        pointType: null,
        meetingNumber: 0,
      );

  @override
  Future<List<VoteMembers>> getVoteMembers(final int voteId) async => [];

  @override
  Future<VoteList> getVotes(final int pageNumber, final int pageSize) async =>
      VoteList(totalPages: 1, content: []);
}
